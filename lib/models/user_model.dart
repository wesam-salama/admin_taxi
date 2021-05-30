import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // String id;
  String email;
  String name;

  UserModel({
    this.email,
    this.name,
  });

  UserModel.formJson(DocumentSnapshot documentSnapshot) {
    this.email = documentSnapshot.data()['email'];
    this.name = documentSnapshot.data()['name'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': this.id,
      'email': this.email,
      'name': this.name,
    };
  }
}
