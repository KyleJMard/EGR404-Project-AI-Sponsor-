import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DrinkPresetsRecord extends FirestoreRecord {
  DrinkPresetsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "drink_name" field.
  String? _drinkName;
  String get drinkName => _drinkName ?? '';
  bool hasDrinkName() => _drinkName != null;

  // "drink_size" field.
  double? _drinkSize;
  double get drinkSize => _drinkSize ?? 0.0;
  bool hasDrinkSize() => _drinkSize != null;

  // "drink_abv" field.
  double? _drinkAbv;
  double get drinkAbv => _drinkAbv ?? 0.0;
  bool hasDrinkAbv() => _drinkAbv != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "drink_size_type" field.
  String? _drinkSizeType;
  String get drinkSizeType => _drinkSizeType ?? '';
  bool hasDrinkSizeType() => _drinkSizeType != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "count" field.
  int? _count;
  int get count => _count ?? 0;
  bool hasCount() => _count != null;

  // "calories" field.
  int? _calories;
  int get calories => _calories ?? 0;
  bool hasCalories() => _calories != null;

  // "drinkTab" field.
  String? _drinkTab;
  String get drinkTab => _drinkTab ?? '';
  bool hasDrinkTab() => _drinkTab != null;

  void _initializeFields() {
    _drinkName = snapshotData['drink_name'] as String?;
    _drinkSize = castToType<double>(snapshotData['drink_size']);
    _drinkAbv = castToType<double>(snapshotData['drink_abv']);
    _user = snapshotData['user'] as DocumentReference?;
    _drinkSizeType = snapshotData['drink_size_type'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _count = castToType<int>(snapshotData['count']);
    _calories = castToType<int>(snapshotData['calories']);
    _drinkTab = snapshotData['drinkTab'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('drinkPresets');

  static Stream<DrinkPresetsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DrinkPresetsRecord.fromSnapshot(s));

  static Future<DrinkPresetsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DrinkPresetsRecord.fromSnapshot(s));

  static DrinkPresetsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DrinkPresetsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DrinkPresetsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DrinkPresetsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DrinkPresetsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DrinkPresetsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDrinkPresetsRecordData({
  String? drinkName,
  double? drinkSize,
  double? drinkAbv,
  DocumentReference? user,
  String? drinkSizeType,
  double? price,
  int? count,
  int? calories,
  String? drinkTab,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'drink_name': drinkName,
      'drink_size': drinkSize,
      'drink_abv': drinkAbv,
      'user': user,
      'drink_size_type': drinkSizeType,
      'price': price,
      'count': count,
      'calories': calories,
      'drinkTab': drinkTab,
    }.withoutNulls,
  );

  return firestoreData;
}

class DrinkPresetsRecordDocumentEquality
    implements Equality<DrinkPresetsRecord> {
  const DrinkPresetsRecordDocumentEquality();

  @override
  bool equals(DrinkPresetsRecord? e1, DrinkPresetsRecord? e2) {
    return e1?.drinkName == e2?.drinkName &&
        e1?.drinkSize == e2?.drinkSize &&
        e1?.drinkAbv == e2?.drinkAbv &&
        e1?.user == e2?.user &&
        e1?.drinkSizeType == e2?.drinkSizeType &&
        e1?.price == e2?.price &&
        e1?.count == e2?.count &&
        e1?.calories == e2?.calories &&
        e1?.drinkTab == e2?.drinkTab;
  }

  @override
  int hash(DrinkPresetsRecord? e) => const ListEquality().hash([
        e?.drinkName,
        e?.drinkSize,
        e?.drinkAbv,
        e?.user,
        e?.drinkSizeType,
        e?.price,
        e?.count,
        e?.calories,
        e?.drinkTab
      ]);

  @override
  bool isValidKey(Object? o) => o is DrinkPresetsRecord;
}
