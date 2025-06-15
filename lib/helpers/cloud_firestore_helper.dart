import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreHelper {
  CloudFirestoreHelper._();
  static final CloudFirestoreHelper cloudFirestoreHelper =
      CloudFirestoreHelper._();

  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference notesRef;
  late CollectionReference counterRef;

  connectionWithNotesCollection() {
    notesRef = firebaseFirestore.collection('notes');
  }

  connectionWithCounterCollection() {
    counterRef = firebaseFirestore.collection('counter');
  }

  Stream<QuerySnapshot> selectRecords({String? searchText}) {
    connectionWithNotesCollection();

    // Query the notes collection
    Query query = notesRef;

    // If searchText is provided, apply a filter based on the title field
    if (searchText != null && searchText.isNotEmpty) {
      query = query
          .where('title', isGreaterThanOrEqualTo: searchText)
          .where('title', isLessThanOrEqualTo: searchText + '\uf8ff');

    }

    return query.snapshots();
  }

  Future<void> insertData({required Map<String, dynamic> data}) async {
    connectionWithCounterCollection();
    connectionWithNotesCollection();

    DocumentSnapshot documentSnapshot =
        await counterRef.doc("note_counter").get();

    Map<String, dynamic> counterData =
        documentSnapshot.data() as Map<String, dynamic>;

    int counter = counterData["counter"];

    await notesRef.doc("${++counter}").set(data);

    await counterRef.doc("note_counter").update({"counter": counter});
  }

  Future<void> updateRecords(
      {required String id, required Map<String, dynamic> data}) async {
    connectionWithNotesCollection();

    notesRef.doc(id).update(data);
  }

  Future<void> deleteRecords({required String id}) async {
    connectionWithNotesCollection();

    notesRef.doc(id).delete();
  }

  Future<bool> checkDataExist() async {
    connectionWithNotesCollection();

    QuerySnapshot querySnapshot = await notesRef.get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> deleteAllRecords() async {
    connectionWithNotesCollection();

    WriteBatch batch = firebaseFirestore.batch();

    QuerySnapshot querySnapshot = await notesRef.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
