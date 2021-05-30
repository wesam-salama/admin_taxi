// import 'package:ecommerce_user_side/helper/shared_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FbAuth {
  FbAuth._();
  static final FbAuth auth = FbAuth._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// ***********************  Login with email and password *************************
  GlobalKey<ScaffoldState> scaffoldKeyLogin = GlobalKey<ScaffoldState>();

  Future<User> loginUsingEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (authResult.user != null) {
        return authResult.user;
      } else {}
    } catch (error) {
      scaffoldKeyLogin.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(error.toString().split(',')[1].substring(0, 25))));
    }
  }
// ********************************************************************************

//*************************** Register ********************************************
  GlobalKey<ScaffoldState> scaffoldKeyRegister = GlobalKey<ScaffoldState>();

  Future<User> registerUsingEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        return authResult.user;
      } else {}
    } catch (error) {
      scaffoldKeyRegister.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(error.toString().split(',')[1])));
    }
  }
// ********************************************************************************

//*************************** Sign Out ********************************************

  signOut() async {
    await firebaseAuth.signOut();
  }
// ********************************************************************************

}
