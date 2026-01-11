// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TableDataStruct extends FFSupabaseStruct {
  TableDataStruct({
    Color? color,
    int? maxSeat,
    int? minSeat,
    String? tableName,
    double? price,
    List<double>? xi,
    List<double>? yi,
    String? type,
    TableStatusStruct? status,
    List<ReservedUserDataStruct>? userData,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _color = color,
        _maxSeat = maxSeat,
        _minSeat = minSeat,
        _tableName = tableName,
        _price = price,
        _xi = xi,
        _yi = yi,
        _type = type,
        _status = status,
        _userData = userData,
        super(supabaseUtilData);

  // "color" field.
  Color? _color;
  Color? get color => _color;
  set color(Color? val) => _color = val;

  bool hasColor() => _color != null;

  // "max_seat" field.
  int? _maxSeat;
  int get maxSeat => _maxSeat ?? 0;
  set maxSeat(int? val) => _maxSeat = val;

  void incrementMaxSeat(int amount) => maxSeat = maxSeat + amount;

  bool hasMaxSeat() => _maxSeat != null;

  // "min_seat" field.
  int? _minSeat;
  int get minSeat => _minSeat ?? 0;
  set minSeat(int? val) => _minSeat = val;

  void incrementMinSeat(int amount) => minSeat = minSeat + amount;

  bool hasMinSeat() => _minSeat != null;

  // "table_name" field.
  String? _tableName;
  String get tableName => _tableName ?? '';
  set tableName(String? val) => _tableName = val;

  bool hasTableName() => _tableName != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;

  void incrementPrice(double amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "xi" field.
  List<double>? _xi;
  List<double> get xi => _xi ?? const [];
  set xi(List<double>? val) => _xi = val;

  void updateXi(Function(List<double>) updateFn) {
    updateFn(_xi ??= []);
  }

  bool hasXi() => _xi != null;

  // "yi" field.
  List<double>? _yi;
  List<double> get yi => _yi ?? const [];
  set yi(List<double>? val) => _yi = val;

  void updateYi(Function(List<double>) updateFn) {
    updateFn(_yi ??= []);
  }

  bool hasYi() => _yi != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "status" field.
  TableStatusStruct? _status;
  TableStatusStruct get status => _status ?? TableStatusStruct();
  set status(TableStatusStruct? val) => _status = val;

  void updateStatus(Function(TableStatusStruct) updateFn) {
    updateFn(_status ??= TableStatusStruct());
  }

  bool hasStatus() => _status != null;

  // "user_data" field.
  List<ReservedUserDataStruct>? _userData;
  List<ReservedUserDataStruct> get userData => _userData ?? const [];
  set userData(List<ReservedUserDataStruct>? val) => _userData = val;

  void updateUserData(Function(List<ReservedUserDataStruct>) updateFn) {
    updateFn(_userData ??= []);
  }

  bool hasUserData() => _userData != null;

  static TableDataStruct fromMap(Map<String, dynamic> data) => TableDataStruct(
        color: getSchemaColor(data['color']),
        maxSeat: castToType<int>(data['max_seat']),
        minSeat: castToType<int>(data['min_seat']),
        tableName: data['table_name'] as String?,
        price: castToType<double>(data['price']),
        xi: getDataList(data['xi']),
        yi: getDataList(data['yi']),
        type: data['type'] as String?,
        status: data['status'] is TableStatusStruct
            ? data['status']
            : TableStatusStruct.maybeFromMap(data['status']),
        userData: getStructList(
          data['user_data'],
          ReservedUserDataStruct.fromMap,
        ),
      );

  static TableDataStruct? maybeFromMap(dynamic data) => data is Map
      ? TableDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'color': _color,
        'max_seat': _maxSeat,
        'min_seat': _minSeat,
        'table_name': _tableName,
        'price': _price,
        'xi': _xi,
        'yi': _yi,
        'type': _type,
        'status': _status?.toMap(),
        'user_data': _userData?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'color': serializeParam(
          _color,
          ParamType.Color,
        ),
        'max_seat': serializeParam(
          _maxSeat,
          ParamType.int,
        ),
        'min_seat': serializeParam(
          _minSeat,
          ParamType.int,
        ),
        'table_name': serializeParam(
          _tableName,
          ParamType.String,
        ),
        'price': serializeParam(
          _price,
          ParamType.double,
        ),
        'xi': serializeParam(
          _xi,
          ParamType.double,
          isList: true,
        ),
        'yi': serializeParam(
          _yi,
          ParamType.double,
          isList: true,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.DataStruct,
        ),
        'user_data': serializeParam(
          _userData,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static TableDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      TableDataStruct(
        color: deserializeParam(
          data['color'],
          ParamType.Color,
          false,
        ),
        maxSeat: deserializeParam(
          data['max_seat'],
          ParamType.int,
          false,
        ),
        minSeat: deserializeParam(
          data['min_seat'],
          ParamType.int,
          false,
        ),
        tableName: deserializeParam(
          data['table_name'],
          ParamType.String,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.double,
          false,
        ),
        xi: deserializeParam<double>(
          data['xi'],
          ParamType.double,
          true,
        ),
        yi: deserializeParam<double>(
          data['yi'],
          ParamType.double,
          true,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        status: deserializeStructParam(
          data['status'],
          ParamType.DataStruct,
          false,
          structBuilder: TableStatusStruct.fromSerializableMap,
        ),
        userData: deserializeStructParam<ReservedUserDataStruct>(
          data['user_data'],
          ParamType.DataStruct,
          true,
          structBuilder: ReservedUserDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'TableDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TableDataStruct &&
        color == other.color &&
        maxSeat == other.maxSeat &&
        minSeat == other.minSeat &&
        tableName == other.tableName &&
        price == other.price &&
        listEquality.equals(xi, other.xi) &&
        listEquality.equals(yi, other.yi) &&
        type == other.type &&
        status == other.status &&
        listEquality.equals(userData, other.userData);
  }

  @override
  int get hashCode => ListEquality().hash([
        color,
        maxSeat,
        minSeat,
        tableName,
        price,
        xi,
        yi,
        type,
        status,
        userData
      ]);
}

TableDataStruct createTableDataStruct({
  Color? color,
  int? maxSeat,
  int? minSeat,
  String? tableName,
  double? price,
  String? type,
  TableStatusStruct? status,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TableDataStruct(
      color: color,
      maxSeat: maxSeat,
      minSeat: minSeat,
      tableName: tableName,
      price: price,
      type: type,
      status: status ?? (clearUnsetFields ? TableStatusStruct() : null),
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TableDataStruct? updateTableDataStruct(
  TableDataStruct? tableData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    tableData
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTableDataStructData(
  Map<String, dynamic> supabaseData,
  TableDataStruct? tableData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (tableData == null) {
    return;
  }
  if (tableData.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && tableData.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final tableDataData = getTableDataFirestoreData(tableData, forFieldValue);
  final nestedData = tableDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = tableData.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTableDataFirestoreData(
  TableDataStruct? tableData, [
  bool forFieldValue = false,
]) {
  if (tableData == null) {
    return {};
  }
  final supabaseData = mapToSupabase(tableData.toMap());

  // Handle nested data for "status" field.
  addTableStatusStructData(
    supabaseData,
    tableData.hasStatus() ? tableData.status : null,
    'status',
    forFieldValue,
  );

  // Add any Firestore field values
  tableData.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getTableDataListFirestoreData(
  List<TableDataStruct>? tableDatas,
) =>
    tableDatas?.map((e) => getTableDataFirestoreData(e, true)).toList() ?? [];
