import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
export 'package:collection/collection.dart'; // For ListEquality in structs

// We don't import cloud_firestore here to avoid conflicts.
// The app will import THIS file instead of cloud_firestore.

class SupabaseFirestore {
  static final SupabaseFirestore instance = SupabaseFirestore._();
  SupabaseFirestore._();

  CollectionReference collection(String path) {
    return CollectionReference(path);
  }

  DocumentReference doc(String path) {
    // path is usually "collection/docId"
    final parts = path.split('/');
    if (parts.length >= 2) {
      return CollectionReference(parts[0]).doc(parts[1]);
    }
    return CollectionReference(parts[0]).doc(null);
  }

  Future<T> runTransaction<T>(
      Future<T> Function(Transaction) updateFunction) async {
    final transaction = Transaction();
    final result = await updateFunction(transaction);
    await transaction.commit();
    return result;
  }
}

class CollectionReference extends Query {
  final String path; // Table name in Supabase

  CollectionReference(this.path);

  DocumentReference doc([String? id]) {
    // If ID is null (auto-id), we'll generate one or let Supabase handle insert?
    // Firestore allows doc() -> auto id. Supabase usually needs Insert to get ID unless UUID is generated client side.
    // For shim, we'll generate a UUID if needed.
    final docId = id ?? _generateAutoId();
    return DocumentReference(path, docId);
  }

  // Parent of a collection (if subcollection) might be a DocumentReference.
  // For root collection, it is null.
  // This is a simplification.
  DocumentReference? get parent => null;

  Future<DocumentReference> add(Map<String, dynamic> data) async {
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

class DocumentReference {
  final String path; // Table Name
  final String id; // Primary Key

  DocumentReference(this.path, this.id);

  // Parent is the CollectionReference that contains this document
  CollectionReference get parent => CollectionReference(path);

  CollectionReference collection(String collectionPath) {
    return CollectionReference('$path/$id/$collectionPath');
  }

  // For compatibility
  String get pathString => '$path/$id';

  Future<void> set(Map<String, dynamic> data) async {
    // Upsert equivalent
    await Supabase.instance.client
        .from(path)
        .upsert(_sanitizeData({'id': id, ...data}));
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

  Future<DocumentSnapshot> get() async {
    try {
      final data = await Supabase.instance.client
          .from(path)
          .select()
          .eq('id', id)
          .single();
      return DocumentSnapshot(id, _processReadData(data), true, this);
    } catch (e) {
      // Not found
      return DocumentSnapshot(id, null, false, this);
    }
  }

  Stream<DocumentSnapshot> snapshots({bool includeMetadataChanges = false}) {
    return Supabase.instance.client
        .from(path)
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((List<Map<String, dynamic>> data) {
          if (data.isEmpty) {
            return DocumentSnapshot(id, null, false, this);
          }
          return DocumentSnapshot(id, _processReadData(data.first), true, this);
        });
  }
}

class Query {
  // This is a builder.
  // Problem: Supabase builders are immutable/chainable, Firestore Query is mutable-ish or creates new instances.
  // We'll store constraints.

  String? _collectionPath;
  List<QueryConstraint> _constraints = [];
  int? _limit;
  String? _orderByField;
  bool _descending = false;

  Query(
      [this._collectionPath]); // Constructor for CollectionReference to call super

  // Add constraint and return new Query (to mimic immutability of Firestore calls)
  Query _clone() {
    var q = Query(_collectionPath);
    q._constraints = List.from(_constraints);
    q._limit = _limit;
    q._orderByField = _orderByField;
    q._descending = _descending;
    return q;
  }

  Query where(
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

  Query orderBy(String field, {bool descending = false}) {
    var q = _clone();
    q._orderByField = field;
    q._descending = descending;
    return q;
  }

  Query limit(int limit) {
    var q = _clone();
    q._limit = limit;
    return q;
  }

  // Handlers for pagination (startAfter etc) - skipped for brevity but usually needed.
  Query startAfterDocument(DocumentSnapshot document) {
    // Naive implementation: In Supabase keyset pagination is harder without precise cursor.
    // Ignored for MVP to compile.
    return this;
  }

  Future<QuerySnapshot> get() async {
    var builder = _buildSupabaseQuery();
    // Determine return type? PostgREST generic.
    final data = await builder;
    // data should be List<Map<String, dynamic>>
    final List<dynamic> list = data as List<dynamic>;
    return QuerySnapshot(list
        .map((e) => DocumentSnapshot(e['id'].toString(), _processReadData(e),
            true, DocumentReference(_collectionPath!, e['id'].toString())))
        .toList());
  }

  Stream<QuerySnapshot> snapshots() {
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
      return QuerySnapshot(data
          .map((e) => QueryDocumentSnapshot(
              e['id'].toString(),
              _processReadData(e),
              true,
              DocumentReference(_collectionPath!, e['id'].toString())))
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

  Query whereIn(String field, List<Object?> values) {
    return where(field, whereIn: values);
  }
}

class QueryConstraint {
  final String field;
  final String op;
  final dynamic value;
  QueryConstraint(this.field, this.op, this.value);
}

// Added QueryDocumentSnapshot class
class QueryDocumentSnapshot extends DocumentSnapshot {
  QueryDocumentSnapshot(String id, Map<String, dynamic>? data, bool exists,
      DocumentReference reference)
      : super(id, data, exists, reference);
}

class DocumentSnapshot {
  final String id;
  final Map<String, dynamic>? _data;
  final bool exists;
  final DocumentReference reference;

  DocumentSnapshot(this.id, this._data, this.exists, this.reference);

  Map<String, dynamic>? data() => _data;

  // Helper to access fields safely
  dynamic get(String field) => _data?[field];

  // Bracket operator
  dynamic operator [](String field) => _data?[field];
}

class QuerySnapshot {
  final List<DocumentSnapshot> docs;
  QuerySnapshot(this.docs);

  // .size or .length in firestore? .size usually.
  int get size => docs.length;
}

class AggregateQuery {
  final Query query;
  AggregateQuery(this.query);

  Future<AggregateQuerySnapshot> get() async {
    // Supabase count
    // Uses the count() method directly
    final int count = await Supabase.instance.client
        .from(query._collectionPath!)
        .count(CountOption.exact);

    return AggregateQuerySnapshot(count);
  }
}

class AggregateQuerySnapshot {
  final int count;
  AggregateQuerySnapshot(this.count);
}

// FieldValue shim
class FieldValue {
  static dynamic arrayUnion(List elements) {
    // We can't actually return a "Instruction" that Supabase understands natively in simple update map.
    // REALITY CHECK: To support this without changing UI code (which passes this to update()),
    // we might need to intercept this in DocumentReference.update().
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

class FirebaseFirestore {
  static SupabaseFirestore get instance => SupabaseFirestore.instance;
}

class Transaction {
  final List<Future Function()> _operations = [];

  Future<DocumentSnapshot> get(DocumentReference ref) {
    return ref.get();
  }

  void update(DocumentReference ref, Map<String, dynamic> data) {
    _operations.add(() => ref.update(data));
  }

  void set(DocumentReference ref, Map<String, dynamic> data,
      [SetOptions? options]) {
    // If SetOptions merge=true, use set(upsert).
    // The Shim DocumentReference.set usually implies Upsert alias.
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
    if (value is DocumentReference) {
      valStr = (value as DocumentReference).id;
    }
    return '$field.$operator.$valStr';
  }
}
