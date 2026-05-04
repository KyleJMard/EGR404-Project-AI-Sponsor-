import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DrinkTotalsRecord extends FirestoreRecord {
  DrinkTotalsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "count" field.
  int? _count;
  int get count => _count ?? 0;
  bool hasCount() => _count != null;

  // "ownerUid" field.
  String? _ownerUid;
  String get ownerUid => _ownerUid ?? '';
  bool hasOwnerUid() => _ownerUid != null;

  // "drinkKey" field.
  String? _drinkKey;
  String get drinkKey => _drinkKey ?? '';
  bool hasDrinkKey() => _drinkKey != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "size_ml" field.
  double? _sizeMl;
  double get sizeMl => _sizeMl ?? 0.0;
  bool hasSizeMl() => _sizeMl != null;

  // "lastAddedAt" field.
  DateTime? _lastAddedAt;
  DateTime? get lastAddedAt => _lastAddedAt;
  bool hasLastAddedAt() => _lastAddedAt != null;

  // "removed" field.
  bool? _removed;
  bool get removed => _removed ?? false;
  bool hasRemoved() => _removed != null;

  // "abv" field.
  double? _abv;
  double get abv => _abv ?? 0.0;
  bool hasAbv() => _abv != null;

  // "total_ml_consumed" field.
  double? _totalMlConsumed;
  double get totalMlConsumed => _totalMlConsumed ?? 0.0;
  bool hasTotalMlConsumed() => _totalMlConsumed != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "cost" field.
  double? _cost;
  double get cost => _cost ?? 0.0;
  bool hasCost() => _cost != null;

  // "tabName" field.
  String? _tabName;
  String get tabName => _tabName ?? '';
  bool hasTabName() => _tabName != null;

  // "dayStart" field.
  DateTime? _dayStart;
  DateTime? get dayStart => _dayStart;
  bool hasDayStart() => _dayStart != null;

  // "dayKey" field.
  String? _dayKey;
  String get dayKey => _dayKey ?? '';
  bool hasDayKey() => _dayKey != null;

  // "calories" field.
  int? _calories;
  int get calories => _calories ?? 0;
  bool hasCalories() => _calories != null;

  // "unit_calories" field.
  int? _unitCalories;
  int get unitCalories => _unitCalories ?? 0;
  bool hasUnitCalories() => _unitCalories != null;

  // "unit_cost" field.
  double? _unitCost;
  double get unitCost => _unitCost ?? 0.0;
  bool hasUnitCost() => _unitCost != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _count = castToType<int>(snapshotData['count']);
    _ownerUid = snapshotData['ownerUid'] as String?;
    _drinkKey = snapshotData['drinkKey'] as String?;
    _name = snapshotData['name'] as String?;
    _sizeMl = castToType<double>(snapshotData['size_ml']);
    _lastAddedAt = snapshotData['lastAddedAt'] as DateTime?;
    _removed = snapshotData['removed'] as bool?;
    _abv = castToType<double>(snapshotData['abv']);
    _totalMlConsumed = castToType<double>(snapshotData['total_ml_consumed']);
    _date = snapshotData['date'] as DateTime?;
    _cost = castToType<double>(snapshotData['cost']);
    _tabName = snapshotData['tabName'] as String?;
    _dayStart = snapshotData['dayStart'] as DateTime?;
    _dayKey = snapshotData['dayKey'] as String?;
    _calories = castToType<int>(snapshotData['calories']);
    _unitCalories = castToType<int>(snapshotData['unit_calories']);
    _unitCost = castToType<double>(snapshotData['unit_cost']);
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('drinkTotals');

  static Stream<DrinkTotalsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DrinkTotalsRecord.fromSnapshot(s));

  static Future<DrinkTotalsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DrinkTotalsRecord.fromSnapshot(s));

  static DrinkTotalsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DrinkTotalsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DrinkTotalsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DrinkTotalsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DrinkTotalsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DrinkTotalsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDrinkTotalsRecordData({
  int? count,
  String? ownerUid,
  String? drinkKey,
  String? name,
  double? sizeMl,
  DateTime? lastAddedAt,
  bool? removed,
  double? abv,
  double? totalMlConsumed,
  DateTime? date,
  double? cost,
  String? tabName,
  DateTime? dayStart,
  String? dayKey,
  int? calories,
  int? unitCalories,
  double? unitCost,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'count': count,
      'ownerUid': ownerUid,
      'drinkKey': drinkKey,
      'name': name,
      'size_ml': sizeMl,
      'lastAddedAt': lastAddedAt,
      'removed': removed,
      'abv': abv,
      'total_ml_consumed': totalMlConsumed,
      'date': date,
      'cost': cost,
      'tabName': tabName,
      'dayStart': dayStart,
      'dayKey': dayKey,
      'calories': calories,
      'unit_calories': unitCalories,
      'unit_cost': unitCost,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class DrinkTotalsRecordDocumentEquality implements Equality<DrinkTotalsRecord> {
  const DrinkTotalsRecordDocumentEquality();

  @override
  bool equals(DrinkTotalsRecord? e1, DrinkTotalsRecord? e2) {
    return e1?.count == e2?.count &&
        e1?.ownerUid == e2?.ownerUid &&
        e1?.drinkKey == e2?.drinkKey &&
        e1?.name == e2?.name &&
        e1?.sizeMl == e2?.sizeMl &&
        e1?.lastAddedAt == e2?.lastAddedAt &&
        e1?.removed == e2?.removed &&
        e1?.abv == e2?.abv &&
        e1?.totalMlConsumed == e2?.totalMlConsumed &&
        e1?.date == e2?.date &&
        e1?.cost == e2?.cost &&
        e1?.tabName == e2?.tabName &&
        e1?.dayStart == e2?.dayStart &&
        e1?.dayKey == e2?.dayKey &&
        e1?.calories == e2?.calories &&
        e1?.unitCalories == e2?.unitCalories &&
        e1?.unitCost == e2?.unitCost &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(DrinkTotalsRecord? e) => const ListEquality().hash([
        e?.count,
        e?.ownerUid,
        e?.drinkKey,
        e?.name,
        e?.sizeMl,
        e?.lastAddedAt,
        e?.removed,
        e?.abv,
        e?.totalMlConsumed,
        e?.date,
        e?.cost,
        e?.tabName,
        e?.dayStart,
        e?.dayKey,
        e?.calories,
        e?.unitCalories,
        e?.unitCost,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is DrinkTotalsRecord;
}
