import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DrinkTabsRecord extends FirestoreRecord {
  DrinkTabsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "ownerUid" field.
  String? _ownerUid;
  String get ownerUid => _ownerUid ?? '';
  bool hasOwnerUid() => _ownerUid != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "archived" field.
  bool? _archived;
  bool get archived => _archived ?? false;
  bool hasArchived() => _archived != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _ownerUid = snapshotData['ownerUid'] as String?;
    _name = snapshotData['name'] as String?;
    _archived = snapshotData['archived'] as bool?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('drinkTabs');

  static Stream<DrinkTabsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DrinkTabsRecord.fromSnapshot(s));

  static Future<DrinkTabsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DrinkTabsRecord.fromSnapshot(s));

  static DrinkTabsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DrinkTabsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DrinkTabsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DrinkTabsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DrinkTabsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DrinkTabsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDrinkTabsRecordData({
  String? ownerUid,
  String? name,
  bool? archived,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'ownerUid': ownerUid,
      'name': name,
      'archived': archived,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class DrinkTabsRecordDocumentEquality implements Equality<DrinkTabsRecord> {
  const DrinkTabsRecordDocumentEquality();

  @override
  bool equals(DrinkTabsRecord? e1, DrinkTabsRecord? e2) {
    return e1?.ownerUid == e2?.ownerUid &&
        e1?.name == e2?.name &&
        e1?.archived == e2?.archived &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(DrinkTabsRecord? e) => const ListEquality()
      .hash([e?.ownerUid, e?.name, e?.archived, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is DrinkTabsRecord;
}
