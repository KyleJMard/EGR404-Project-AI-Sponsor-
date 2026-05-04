import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class YearlyDrinkLogRecord extends FirestoreRecord {
  YearlyDrinkLogRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "yearKey" field.
  String? _yearKey;
  String get yearKey => _yearKey ?? '';
  bool hasYearKey() => _yearKey != null;

  // "yearStart" field.
  DateTime? _yearStart;
  DateTime? get yearStart => _yearStart;
  bool hasYearStart() => _yearStart != null;

  // "yearlyRemoved" field.
  bool? _yearlyRemoved;
  bool get yearlyRemoved => _yearlyRemoved ?? false;
  bool hasYearlyRemoved() => _yearlyRemoved != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _yearKey = snapshotData['yearKey'] as String?;
    _yearStart = snapshotData['yearStart'] as DateTime?;
    _yearlyRemoved = snapshotData['yearlyRemoved'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('yearlyDrinkLog');

  static Stream<YearlyDrinkLogRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => YearlyDrinkLogRecord.fromSnapshot(s));

  static Future<YearlyDrinkLogRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => YearlyDrinkLogRecord.fromSnapshot(s));

  static YearlyDrinkLogRecord fromSnapshot(DocumentSnapshot snapshot) =>
      YearlyDrinkLogRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static YearlyDrinkLogRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      YearlyDrinkLogRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'YearlyDrinkLogRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is YearlyDrinkLogRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createYearlyDrinkLogRecordData({
  String? uid,
  String? yearKey,
  DateTime? yearStart,
  bool? yearlyRemoved,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'yearKey': yearKey,
      'yearStart': yearStart,
      'yearlyRemoved': yearlyRemoved,
    }.withoutNulls,
  );

  return firestoreData;
}

class YearlyDrinkLogRecordDocumentEquality
    implements Equality<YearlyDrinkLogRecord> {
  const YearlyDrinkLogRecordDocumentEquality();

  @override
  bool equals(YearlyDrinkLogRecord? e1, YearlyDrinkLogRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.yearKey == e2?.yearKey &&
        e1?.yearStart == e2?.yearStart &&
        e1?.yearlyRemoved == e2?.yearlyRemoved;
  }

  @override
  int hash(YearlyDrinkLogRecord? e) => const ListEquality()
      .hash([e?.uid, e?.yearKey, e?.yearStart, e?.yearlyRemoved]);

  @override
  bool isValidKey(Object? o) => o is YearlyDrinkLogRecord;
}
