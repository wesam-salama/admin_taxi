import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreAuth {
  FirestoreAuth._();

  static FirestoreAuth firestoreAuth = FirestoreAuth._();

  setUserToFirestore(User admin, Map<String, dynamic> map) async {
    await FirebaseFirestore.instance
        .collection('Admins')
        .doc(admin.uid)
        .set(map);
  }

  Future<DocumentSnapshot> getUser(User admin) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Admins')
        .doc(admin.uid)
        .get();

    return documentSnapshot;
  }
}
