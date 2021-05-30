import 'package:admin_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_auth_client.dart';

class FirebaseRepositoryAuth {
  FirebaseRepositoryAuth._();

  static FirebaseRepositoryAuth firebaseRepository = FirebaseRepositoryAuth._();

  setUserToFirestore(User admin, UserModel userModel) async {
    await FirestoreAuth.firestoreAuth
        .setUserToFirestore(admin, userModel.toJson());
  }

  Future<UserModel> getUser(User admin) async {
    DocumentSnapshot documentSnapshot =
        await FirestoreAuth.firestoreAuth.getUser(admin);
    UserModel listQuerySnapshot = UserModel.formJson(documentSnapshot);

    return listQuerySnapshot;
  }
}
