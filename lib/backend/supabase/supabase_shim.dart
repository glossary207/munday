import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
export 'package:collection/collection.dart'; // For ListEquality in structs

// We don't import cloud_firestore here to avoid conflicts.
// The app will import THIS file instead of cloud_firestore.

class SupabaseFirestore {
  static final SupabaseFirestore instance = SupabaseFirestore._();
  SupabaseFirestore._();

  SupabaseCollectionRef collection(String path) {
    return SupabaseCollectionRef(path);
  }

  SupabaseDocRef doc(String path) {
    // path is usually "collection/docId"
    final parts = path.split('/');
    if (parts.length >= 2) {
      return SupabaseCollectionRef(parts[0]).doc(parts[1]);
    }
    return SupabaseCollectionRef(parts[0]).doc(null);
  }

  Future<T> runTransaction<T>(
      Future<T> Function(SupabaseTransaction) updateFunction) async {
    final transaction = SupabaseTransaction();
    final result = await updateFunction(transaction);
    await transaction.commit();
    return result;
  }
}

class SupabaseCollectionRef extends SupabaseQuery {
  final String path; // Table name in Supabase

  SupabaseCollectionRef(this.path) : super(path);

  SupabaseDocRef doc([String? id]) {
    // If ID is null (auto-id), we'll generate one or let Supabase handle insert?
    // Firestore allows doc() -> auto id. Supabase usually needs Insert to get ID unless UUID is generated client side.
    // For shim, we'll generate a UUID if needed.
    final docId = id ?? _generateAutoId();
    return SupabaseDocRef(path, docId);
  }

  // Parent of a collection (if subcollection) might be a SupabaseDocRef.
  // For root collection, it is null.
  // This is a simplification.
  SupabaseDocRef? get parent => null;

  Future<SupabaseDocRef> add(Map<String, dynamic> data) async {
    // Supabase insert returns data.
    final res = await Supabase.instance.client
        .from(path)
        .insert(_sanitizeData(data))
        .select()
        .single();
    return doc(res['id']?.toString() ??
        res['uid']?.toString()); // Assuming 'id' or 'uid' column
  }
}

String _generateAutoId() {
  // Simple random string to mimic Firestore autoID if needed immediately
  // Or utilize uuid package if available.
  // For now simple string.
  return DateTime.now().millisecondsSinceEpoch.toString();
}

dynamic _sanitizeData(dynamic data) {
  if (data is DateTime) {
    return data.toIso8601String();
  } else if (data is Timestamp) {
    return data.toDate().toIso8601String();
  } else if (data is Map) {
    return data.map((key, value) => MapEntry(key, _sanitizeData(value)));
  } else if (data is Iterable) {
    return data.map((item) => _sanitizeData(item)).toList();
  }
  return data;
}

dynamic _processReadData(dynamic data) {
  if (data is String) {
    // Attempt to parse ISO8601
    try {
      // Simple check to avoid parsing every string
      if (data.length > 10 &&
          (data.contains('T') || data.contains(' ')) &&
          data.contains(':')) {
        final date = DateTime.tryParse(data);
        if (date != null) {
          return Timestamp.fromDate(date);
        }
      }
    } catch (_) {}
    return data;
  } else if (data is Map) {
    return data.map((key, value) => MapEntry(key, _processReadData(value)));
  } else if (data is List) {
    return data.map((item) => _processReadData(item)).toList();
  }
  return data;
}

class SupabaseDocRef {
  final String path; // Table Name
  final String id; // Primary Key

  SupabaseDocRef(this.path, this.id);

  // Parent is the SupabaseCollectionRef that contains this document
  SupabaseCollectionRef get parent => SupabaseCollectionRef(path);

  SupabaseCollectionRef collection(String collectionPath) {
    return SupabaseCollectionRef('$path/$id/$collectionPath');
  }

  // For compatibility
  String get pathString => '$path/$id';

  Future<void> set(Map<String, dynamic> data) async {
    print('DEBUG: SupabaseDocRef.set called for $path/$id');
    try {
      final sanitized = _sanitizeData({'id': id, ...data});
      // Upsert equivalent
      await Supabase.instance.client.from(path).upsert(sanitized);
    } catch (e) {
      print('DEBUG: Error in SupabaseDocRef.set: $e');
      rethrow;
    }
  }

  Future<void> update(Map<String, dynamic> data) async {
    // Check if any value is a FieldValue marker
    bool hasSpecialFields = data.values.any((v) =>
        v is _FieldValueArrayUnion ||
        v is _FieldValueArrayRemove ||
        v is _FieldValueIncrement);

    if (hasSpecialFields) {
      // Read-Modify-Write strategy
      final currentSnap = await Supabase.instance.client
          .from(path)
          .select()
          .eq('id', id)
          .single();
      Map<String, dynamic> currentData = Map<String, dynamic>.from(currentSnap);

      data.forEach((key, value) {
        if (value is _FieldValueArrayUnion) {
          List<dynamic> existing = List.from(currentData[key] ?? []);
          for (var element in value.elements) {
            if (!existing.contains(element)) existing.add(element);
          }
          currentData[key] = existing;
        } else if (value is _FieldValueArrayRemove) {
          List<dynamic> existing = List.from(currentData[key] ?? []);
          existing.removeWhere((e) => value.elements.contains(e));
          currentData[key] = existing;
        } else if (value is _FieldValueIncrement) {
          num existing = (currentData[key] ?? 0) as num;
          currentData[key] = existing + value.value;
        } else {
          currentData[key] = value;
        }
      });

      await Supabase.instance.client
          .from(path)
          .update(currentData)
          .eq('id', id);
    } else {
      // Direct update
      await Supabase.instance.client
          .from(path)
          .update(_sanitizeData(data))
          .eq('id', id);
    }
  }

  Future<void> delete() async {
    await Supabase.instance.client.from(path).delete().eq('id', id);
  }

  Future<SupabaseDocSnapshot> get() async {
    try {
      final data = await Supabase.instance.client
          .from(path)
          .select()
          .eq('id', id)
          .single();
      return SupabaseDocSnapshot(id, _processReadData(data), true, this);
    } catch (e) {
      // Not found
      return SupabaseDocSnapshot(id, null, false, this);
    }
  }

  Stream<SupabaseDocSnapshot> snapshots({bool includeMetadataChanges = false}) {
    return Supabase.instance.client
        .from(path)
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((List<Map<String, dynamic>> data) {
          if (data.isEmpty) {
            return SupabaseDocSnapshot(id, null, false, this);
          }
          return SupabaseDocSnapshot(
              id, _processReadData(data.first), true, this);
        });
  }
}

class SupabaseQuery {
  // This is a builder.
  // Problem: Supabase builders are immutable/chainable, Firestore Query is mutable-ish or creates new instances.
  // We'll store constraints.

  String? _collectionPath;
  List<QueryConstraint> _constraints = [];
  int? _limit;
  String? _orderByField;
  bool _descending = false;

  SupabaseQuery(
      [this._collectionPath]); // Constructor for SupabaseCollectionRef to call super

  // Add constraint and return new Query (to mimic immutability of Firestore calls)
  SupabaseQuery _clone() {
    var q = SupabaseQuery(_collectionPath);
    q._constraints = List.from(_constraints);
    q._limit = _limit;
    q._orderByField = _orderByField;
    q._descending = _descending;
    return q;
  }

  SupabaseQuery where(
    dynamic field, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    if (field is Filter) {
      var q = _clone();
      q._constraints.add(QueryConstraint('', 'filter', field));
      return q;
    }
    String fieldName = field as String;
    var q = _clone();
    if (isEqualTo != null)
      q._constraints.add(QueryConstraint(fieldName, 'eq', isEqualTo));
    if (isNotEqualTo != null)
      q._constraints.add(QueryConstraint(fieldName, 'neq', isNotEqualTo));
    if (isLessThan != null)
      q._constraints.add(QueryConstraint(fieldName, 'lt', isLessThan));
    if (isLessThanOrEqualTo != null)
      q._constraints
          .add(QueryConstraint(fieldName, 'lte', isLessThanOrEqualTo));
    if (isGreaterThan != null)
      q._constraints.add(QueryConstraint(fieldName, 'gt', isGreaterThan));
    if (isGreaterThanOrEqualTo != null)
      q._constraints
          .add(QueryConstraint(fieldName, 'gte', isGreaterThanOrEqualTo));
    if (arrayContains != null)
      q._constraints.add(QueryConstraint(fieldName, 'cs',
          '{path: [arrayContains]}')); // Complex mapping needed
    if (whereIn != null)
      q._constraints.add(QueryConstraint(fieldName, 'in', whereIn));

    // Note: Mappings for arrayContains/etc need precise PostgREST syntax.
    // For MVP we handle basic EQ/IN/GT/LT.
    return q;
  }

  SupabaseQuery orderBy(String field, {bool descending = false}) {
    var q = _clone();
    q._orderByField = field;
    q._descending = descending;
    return q;
  }

  SupabaseQuery limit(int limit) {
    var q = _clone();
    q._limit = limit;
    return q;
  }

  // Handlers for pagination (startAfter etc) - skipped for brevity but usually needed.
  SupabaseQuery startAfterDocument(SupabaseDocSnapshot document) {
    // Naive implementation: In Supabase keyset pagination is harder without precise cursor.
    // Ignored for MVP to compile.
    return this;
  }

  Future<SupabaseQuerySnapshot> get() async {
    var builder = _buildSupabaseQuery();
    // Determine return type? PostgREST generic.
    final data = await builder;
    // data should be List<Map<String, dynamic>>
    final List<dynamic> list = data as List<dynamic>;
    return SupabaseQuerySnapshot(list
        .map((e) => SupabaseDocSnapshot(e['id'].toString(), _processReadData(e),
            true, SupabaseDocRef(_collectionPath!, e['id'].toString())))
        .toList());
  }

  Stream<SupabaseQuerySnapshot> snapshots() {
    // .stream() in Supabase fluter is powerful but has limits (filters).
    // For simple EQ filters it works. Complex filters might need realtime channel subscription manually.
    // We'll try using the stream() method query builder.

    // Warning: .stream() expects simple EQ filters.
    // If _constraints has > eq, we might fallback or error.

    // Changed to dynamic to avoid type errors between SupabaseStreamBuilder and SupabaseStreamFilterBuilder
    dynamic streamBuilder = Supabase.instance.client
        .from(_collectionPath!)
        .stream(primaryKey: ['id']);
    // Apply order
    if (_orderByField != null) {
      streamBuilder =
          streamBuilder.order(_orderByField!, ascending: !_descending);
    }
    if (_limit != null) {
      streamBuilder = streamBuilder.limit(_limit!);
    }
    // Apply EQ filters only for stream
    for (var c in _constraints) {
      if (c.op == 'eq') {
        streamBuilder = streamBuilder.eq(c.field, c.value);
      }
    }

    // Cast the result of the stream to the expected type
    return (streamBuilder as Stream<List<Map<String, dynamic>>>)
        .map((List<Map<String, dynamic>> data) {
      return SupabaseQuerySnapshot(data
          .map((e) => SupabaseQueryDocSnapshot(
              e['id'].toString(),
              _processReadData(e),
              true,
              SupabaseDocRef(_collectionPath!, e['id'].toString())))
          .toList());
    });
  }

  // Future<int> count() ... (Firestore aggregate query)
  AggregateQuery count() => AggregateQuery(this);

  dynamic _buildSupabaseQuery() {
    dynamic query = Supabase.instance.client.from(_collectionPath!).select();
    for (var c in _constraints) {
      switch (c.op) {
        case 'eq':
          query = query.eq(c.field, c.value);
          break;
        case 'neq':
          query = query.neq(c.field, c.value);
          break;
        case 'lt':
          query = query.lt(c.field, c.value);
          break;
        case 'lte':
          query = query.lte(c.field, c.value);
          break;
        case 'gt':
          query = query.gt(c.field, c.value);
          break;
        case 'gte':
          query = query.gte(c.field, c.value);
          break;
        case 'in':
          query = query.inFilter(c.field, c.value as List);
          break;
        case 'filter':
          Filter f = c.value;
          if (f.orFilters != null) {
            query = query.or(f.toSupabaseString());
          }
          break;
      }
    }
    if (_orderByField != null) {
      query = query.order(_orderByField!, ascending: !_descending);
    }
    if (_limit != null) {
      query = query.limit(_limit!);
    }
    return query;
  }

  SupabaseQuery whereIn(String field, List<Object?> values) {
    return where(field, whereIn: values);
  }
}

class QueryConstraint {
  final String field;
  final String op;
  final dynamic value;
  QueryConstraint(this.field, this.op, this.value);
}

// Added SupabaseQueryDocSnapshot class
class SupabaseQueryDocSnapshot extends SupabaseDocSnapshot {
  SupabaseQueryDocSnapshot(String id, Map<String, dynamic>? data, bool exists,
      SupabaseDocRef reference)
      : super(id, data, exists, reference);
}

class SupabaseDocSnapshot {
  final String id;
  final Map<String, dynamic>? _data;
  final bool exists;
  final SupabaseDocRef reference;

  SupabaseDocSnapshot(this.id, this._data, this.exists, this.reference);

  Map<String, dynamic>? data() => _data;

  // Helper to access fields safely
  dynamic get(String field) => _data?[field];

  // Bracket operator
  dynamic operator [](String field) => _data?[field];
}

class SupabaseQuerySnapshot {
  final List<SupabaseDocSnapshot> docs;
  SupabaseQuerySnapshot(this.docs);

  // .size or .length in firestore? .size usually.
  int get size => docs.length;
}

class AggregateQuery {
  final SupabaseQuery query;
  AggregateQuery(this.query);

  Future<AggregateSupabaseQuerySnapshot> get() async {
    // Supabase count
    // Uses the count() method directly
    final int count = await Supabase.instance.client
        .from(query._collectionPath!)
        .count(CountOption.exact);

    return AggregateSupabaseQuerySnapshot(count);
  }
}

class AggregateSupabaseQuerySnapshot {
  final int count;
  AggregateSupabaseQuerySnapshot(this.count);
}

// FieldValue shim
class FieldValue {
  static dynamic arrayUnion(List elements) {
    // We can't actually return a "Instruction" that Supabase understands natively in simple update map.
    // REALITY CHECK: To support this without changing UI code (which passes this to update()),
    // we might need to intercept this in SupabaseDocRef.update().
    // For now, let's return a special marker object.
    return _FieldValueArrayUnion(elements);
  }

  static dynamic arrayRemove(List elements) {
    return _FieldValueArrayRemove(elements);
  }

  static dynamic increment(num value) {
    return _FieldValueIncrement(value);
  }

  static dynamic serverTimestamp() {
    return DateTime.now()
        .toIso8601String(); // Supabase uses ISO strings usually.
  }

  static dynamic delete() {
    return null; // or special marker?
  }
}

class _FieldValueArrayUnion {
  final List elements;
  _FieldValueArrayUnion(this.elements);
}

class _FieldValueArrayRemove {
  final List elements;
  _FieldValueArrayRemove(this.elements);
}

class _FieldValueIncrement {
  final num value;
  _FieldValueIncrement(this.value);
}

// Shims for Data Types
class Timestamp {
  final DateTime _date;
  Timestamp(int seconds, int nanoseconds)
      : _date = DateTime.fromMicrosecondsSinceEpoch(
            seconds * 1000000 + nanoseconds ~/ 1000);
  Timestamp.fromDate(this._date);
  DateTime toDate() => _date;
  int get millisecondsSinceEpoch => _date.millisecondsSinceEpoch;
  static Timestamp now() => Timestamp.fromDate(DateTime.now());
}

class GeoPoint {
  final double latitude;
  final double longitude;
  const GeoPoint(this.latitude, this.longitude);
}

class SupabaseTransaction {
  final List<Future Function()> _operations = [];

  Future<SupabaseDocSnapshot> get(SupabaseDocRef ref) {
    return ref.get();
  }

  void update(SupabaseDocRef ref, Map<String, dynamic> data) {
    _operations.add(() => ref.update(data));
  }

  void set(SupabaseDocRef ref, Map<String, dynamic> data,
      [SetOptions? options]) {
    // If SetOptions merge=true, use set(upsert).
    // The Shim SupabaseDocRef.set usually implies Upsert alias.
    _operations.add(() => ref.set(data));
  }

  Future<void> commit() async {
    for (var op in _operations) {
      await op();
    }
  }
}

class SetOptions {
  final bool? merge;
  SetOptions({this.merge});
}

class Filter {
  final String? field;
  final String? operator;
  final Object? value;
  final List<Filter>? orFilters;

  Filter(this.field, {Object? isEqualTo})
      : operator = 'eq',
        value = isEqualTo,
        orFilters = null;

  Filter.or(Filter a, Filter b)
      : field = null,
        operator = null,
        value = null,
        orFilters = [a, b];

  String toSupabaseString() {
    if (orFilters != null) {
      return orFilters!.map((f) => f.toSupabaseString()).join(',');
    }
    String valStr = value.toString();
    if (value is SupabaseDocRef) {
      valStr = (value as SupabaseDocRef).id;
    }
    return '$field.$operator.$valStr';
  }
}
