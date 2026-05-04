import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MonthlyDrinkLogRecord extends FirestoreRecord {
  MonthlyDrinkLogRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "monthKey" field.
  String? _monthKey;
  String get monthKey => _monthKey ?? '';
  bool hasMonthKey() => _monthKey != null;

  // "monthStart" field.
  DateTime? _monthStart;
  DateTime? get monthStart => _monthStart;
  bool hasMonthStart() => _monthStart != null;

  // "monthlyRemoved" field.
  bool? _monthlyRemoved;
  bool get monthlyRemoved => _monthlyRemoved ?? false;
  bool hasMonthlyRemoved() => _monthlyRemoved != null;

  // "yearKey" field.
  String? _yearKey;
  String get yearKey => _yearKey ?? '';
  bool hasYearKey() => _yearKey != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _monthKey = snapshotData['monthKey'] as String?;
    _monthStart = snapshotData['monthStart'] as DateTime?;
    _monthlyRemoved = snapshotData['monthlyRemoved'] as bool?;
    _yearKey = snapshotData['yearKey'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('monthlyDrinkLog');

  static Stream<MonthlyDrinkLogRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MonthlyDrinkLogRecord.fromSnapshot(s));

  static Future<MonthlyDrinkLogRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MonthlyDrinkLogRecord.fromSnapshot(s));

  static MonthlyDrinkLogRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MonthlyDrinkLogRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MonthlyDrinkLogRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MonthlyDrinkLogRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MonthlyDrinkLogRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MonthlyDrinkLogRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMonthlyDrinkLogRecordData({
  String? uid,
  String? monthKey,
  DateTime? monthStart,
  bool? monthlyRemoved,
  String? yearKey,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'monthKey': monthKey,
      'monthStart': monthStart,
      'monthlyRemoved': monthlyRemoved,
      'yearKey': yearKey,
    }.withoutNulls,
  );

  return firestoreData;
}

class MonthlyDrinkLogRecordDocumentEquality
    implements Equality<MonthlyDrinkLogRecord> {
  const MonthlyDrinkLogRecordDocumentEquality();

  @override
  bool equals(MonthlyDrinkLogRecord? e1, MonthlyDrinkLogRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.monthKey == e2?.monthKey &&
        e1?.monthStart == e2?.monthStart &&
        e1?.monthlyRemoved == e2?.monthlyRemoved &&
        e1?.yearKey == e2?.yearKey;
  }

  @override
  int hash(MonthlyDrinkLogRecord? e) => const ListEquality().hash(
      [e?.uid, e?.monthKey, e?.monthStart, e?.monthlyRemoved, e?.yearKey]);

  @override
  bool isValidKey(Object? o) => o is MonthlyDrinkLogRecord;
}
