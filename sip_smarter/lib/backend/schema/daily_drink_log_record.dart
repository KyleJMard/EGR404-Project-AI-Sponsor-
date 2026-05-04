import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DailyDrinkLogRecord extends FirestoreRecord {
  DailyDrinkLogRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  DocumentReference? _uid;
  DocumentReference? get uid => _uid;
  bool hasUid() => _uid != null;

  // "dayStart" field.
  DateTime? _dayStart;
  DateTime? get dayStart => _dayStart;
  bool hasDayStart() => _dayStart != null;

  // "dayEnd" field.
  DateTime? _dayEnd;
  DateTime? get dayEnd => _dayEnd;
  bool hasDayEnd() => _dayEnd != null;

  // "totalMl" field.
  double? _totalMl;
  double get totalMl => _totalMl ?? 0.0;
  bool hasTotalMl() => _totalMl != null;

  // "totalStandardDrinks" field.
  int? _totalStandardDrinks;
  int get totalStandardDrinks => _totalStandardDrinks ?? 0;
  bool hasTotalStandardDrinks() => _totalStandardDrinks != null;

  // "dailyRemoved" field.
  bool? _dailyRemoved;
  bool get dailyRemoved => _dailyRemoved ?? false;
  bool hasDailyRemoved() => _dailyRemoved != null;

  // "totalCost" field.
  double? _totalCost;
  double get totalCost => _totalCost ?? 0.0;
  bool hasTotalCost() => _totalCost != null;

  // "monthKey" field.
  String? _monthKey;
  String get monthKey => _monthKey ?? '';
  bool hasMonthKey() => _monthKey != null;

  // "dailyCalories" field.
  double? _dailyCalories;
  double get dailyCalories => _dailyCalories ?? 0.0;
  bool hasDailyCalories() => _dailyCalories != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as DocumentReference?;
    _dayStart = snapshotData['dayStart'] as DateTime?;
    _dayEnd = snapshotData['dayEnd'] as DateTime?;
    _totalMl = castToType<double>(snapshotData['totalMl']);
    _totalStandardDrinks = castToType<int>(snapshotData['totalStandardDrinks']);
    _dailyRemoved = snapshotData['dailyRemoved'] as bool?;
    _totalCost = castToType<double>(snapshotData['totalCost']);
    _monthKey = snapshotData['monthKey'] as String?;
    _dailyCalories = castToType<double>(snapshotData['dailyCalories']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('dailyDrinkLog');

  static Stream<DailyDrinkLogRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DailyDrinkLogRecord.fromSnapshot(s));

  static Future<DailyDrinkLogRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DailyDrinkLogRecord.fromSnapshot(s));

  static DailyDrinkLogRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DailyDrinkLogRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DailyDrinkLogRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DailyDrinkLogRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DailyDrinkLogRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DailyDrinkLogRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDailyDrinkLogRecordData({
  DocumentReference? uid,
  DateTime? dayStart,
  DateTime? dayEnd,
  double? totalMl,
  int? totalStandardDrinks,
  bool? dailyRemoved,
  double? totalCost,
  String? monthKey,
  double? dailyCalories,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'dayStart': dayStart,
      'dayEnd': dayEnd,
      'totalMl': totalMl,
      'totalStandardDrinks': totalStandardDrinks,
      'dailyRemoved': dailyRemoved,
      'totalCost': totalCost,
      'monthKey': monthKey,
      'dailyCalories': dailyCalories,
    }.withoutNulls,
  );

  return firestoreData;
}

class DailyDrinkLogRecordDocumentEquality
    implements Equality<DailyDrinkLogRecord> {
  const DailyDrinkLogRecordDocumentEquality();

  @override
  bool equals(DailyDrinkLogRecord? e1, DailyDrinkLogRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.dayStart == e2?.dayStart &&
        e1?.dayEnd == e2?.dayEnd &&
        e1?.totalMl == e2?.totalMl &&
        e1?.totalStandardDrinks == e2?.totalStandardDrinks &&
        e1?.dailyRemoved == e2?.dailyRemoved &&
        e1?.totalCost == e2?.totalCost &&
        e1?.monthKey == e2?.monthKey &&
        e1?.dailyCalories == e2?.dailyCalories;
  }

  @override
  int hash(DailyDrinkLogRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.dayStart,
        e?.dayEnd,
        e?.totalMl,
        e?.totalStandardDrinks,
        e?.dailyRemoved,
        e?.totalCost,
        e?.monthKey,
        e?.dailyCalories
      ]);

  @override
  bool isValidKey(Object? o) => o is DailyDrinkLogRecord;
}
