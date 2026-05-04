// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// guest added a drink
///
class DrinkEventStruct extends FFFirebaseStruct {
  DrinkEventStruct({
    int? count,
    String? ownerUid,
    String? drinkKey,
    String? name,
    double? sizeMl,
    DateTime? lastAddedAt,
    bool? removed,
    double? abv,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _count = count,
        _ownerUid = ownerUid,
        _drinkKey = drinkKey,
        _name = name,
        _sizeMl = sizeMl,
        _lastAddedAt = lastAddedAt,
        _removed = removed,
        _abv = abv,
        super(firestoreUtilData);

  // "count" field.
  int? _count;
  int get count => _count ?? 0;
  set count(int? val) => _count = val;

  void incrementCount(int amount) => count = count + amount;

  bool hasCount() => _count != null;

  // "ownerUid" field.
  String? _ownerUid;
  String get ownerUid => _ownerUid ?? '';
  set ownerUid(String? val) => _ownerUid = val;

  bool hasOwnerUid() => _ownerUid != null;

  // "drinkKey" field.
  String? _drinkKey;
  String get drinkKey => _drinkKey ?? '';
  set drinkKey(String? val) => _drinkKey = val;

  bool hasDrinkKey() => _drinkKey != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "size_ml" field.
  double? _sizeMl;
  double get sizeMl => _sizeMl ?? 0.0;
  set sizeMl(double? val) => _sizeMl = val;

  void incrementSizeMl(double amount) => sizeMl = sizeMl + amount;

  bool hasSizeMl() => _sizeMl != null;

  // "lastAddedAt" field.
  DateTime? _lastAddedAt;
  DateTime? get lastAddedAt => _lastAddedAt;
  set lastAddedAt(DateTime? val) => _lastAddedAt = val;

  bool hasLastAddedAt() => _lastAddedAt != null;

  // "removed" field.
  bool? _removed;
  bool get removed => _removed ?? false;
  set removed(bool? val) => _removed = val;

  bool hasRemoved() => _removed != null;

  // "abv" field.
  double? _abv;
  double get abv => _abv ?? 0.0;
  set abv(double? val) => _abv = val;

  void incrementAbv(double amount) => abv = abv + amount;

  bool hasAbv() => _abv != null;

  static DrinkEventStruct fromMap(Map<String, dynamic> data) =>
      DrinkEventStruct(
        count: castToType<int>(data['count']),
        ownerUid: data['ownerUid'] as String?,
        drinkKey: data['drinkKey'] as String?,
        name: data['name'] as String?,
        sizeMl: castToType<double>(data['size_ml']),
        lastAddedAt: data['lastAddedAt'] as DateTime?,
        removed: data['removed'] as bool?,
        abv: castToType<double>(data['abv']),
      );

  static DrinkEventStruct? maybeFromMap(dynamic data) => data is Map
      ? DrinkEventStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'count': _count,
        'ownerUid': _ownerUid,
        'drinkKey': _drinkKey,
        'name': _name,
        'size_ml': _sizeMl,
        'lastAddedAt': _lastAddedAt,
        'removed': _removed,
        'abv': _abv,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'count': serializeParam(
          _count,
          ParamType.int,
        ),
        'ownerUid': serializeParam(
          _ownerUid,
          ParamType.String,
        ),
        'drinkKey': serializeParam(
          _drinkKey,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'size_ml': serializeParam(
          _sizeMl,
          ParamType.double,
        ),
        'lastAddedAt': serializeParam(
          _lastAddedAt,
          ParamType.DateTime,
        ),
        'removed': serializeParam(
          _removed,
          ParamType.bool,
        ),
        'abv': serializeParam(
          _abv,
          ParamType.double,
        ),
      }.withoutNulls;

  static DrinkEventStruct fromSerializableMap(Map<String, dynamic> data) =>
      DrinkEventStruct(
        count: deserializeParam(
          data['count'],
          ParamType.int,
          false,
        ),
        ownerUid: deserializeParam(
          data['ownerUid'],
          ParamType.String,
          false,
        ),
        drinkKey: deserializeParam(
          data['drinkKey'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        sizeMl: deserializeParam(
          data['size_ml'],
          ParamType.double,
          false,
        ),
        lastAddedAt: deserializeParam(
          data['lastAddedAt'],
          ParamType.DateTime,
          false,
        ),
        removed: deserializeParam(
          data['removed'],
          ParamType.bool,
          false,
        ),
        abv: deserializeParam(
          data['abv'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'DrinkEventStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DrinkEventStruct &&
        count == other.count &&
        ownerUid == other.ownerUid &&
        drinkKey == other.drinkKey &&
        name == other.name &&
        sizeMl == other.sizeMl &&
        lastAddedAt == other.lastAddedAt &&
        removed == other.removed &&
        abv == other.abv;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [count, ownerUid, drinkKey, name, sizeMl, lastAddedAt, removed, abv]);
}

DrinkEventStruct createDrinkEventStruct({
  int? count,
  String? ownerUid,
  String? drinkKey,
  String? name,
  double? sizeMl,
  DateTime? lastAddedAt,
  bool? removed,
  double? abv,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DrinkEventStruct(
      count: count,
      ownerUid: ownerUid,
      drinkKey: drinkKey,
      name: name,
      sizeMl: sizeMl,
      lastAddedAt: lastAddedAt,
      removed: removed,
      abv: abv,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DrinkEventStruct? updateDrinkEventStruct(
  DrinkEventStruct? drinkEvent, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    drinkEvent
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDrinkEventStructData(
  Map<String, dynamic> firestoreData,
  DrinkEventStruct? drinkEvent,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (drinkEvent == null) {
    return;
  }
  if (drinkEvent.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && drinkEvent.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final drinkEventData = getDrinkEventFirestoreData(drinkEvent, forFieldValue);
  final nestedData = drinkEventData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = drinkEvent.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDrinkEventFirestoreData(
  DrinkEventStruct? drinkEvent, [
  bool forFieldValue = false,
]) {
  if (drinkEvent == null) {
    return {};
  }
  final firestoreData = mapToFirestore(drinkEvent.toMap());

  // Add any Firestore field values
  mapToFirestore(drinkEvent.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDrinkEventListFirestoreData(
  List<DrinkEventStruct>? drinkEvents,
) =>
    drinkEvents?.map((e) => getDrinkEventFirestoreData(e, true)).toList() ?? [];
