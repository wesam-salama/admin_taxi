import 'package:admin_app/auth/auth_firebase.dart';
import 'package:admin_app/models/user_model.dart';
import 'package:admin_app/repositores/firestore_auth_repositories.dart';
import 'package:admin_app/ui/screens/register_success/register_success_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/ui/screens/login_success/login_success_screen.dart';
import 'package:get/get.dart';

class AuthGet extends GetxController {
  String email;
  String password;
  String name;

  saveEmail(String value) {
    this.email = value;
    update();
  }

  savePaswword(String value) {
    this.password = value;
    update();
  }

  saveName(String value) {
    this.name = value;
    update();
  }

  // ***********************  login with email and password *************************
  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  Future<User> loginUsingEmailAndPassword(BuildContext context) async {
    User user =
        await FbAuth.auth.loginUsingEmailAndPassword(this.email, this.password);

    if (user != null) {
      Get.offAll(LoginSuccessScreen());
    }
    update();
    return user;
  }
  // ********************************************************************************

  //*************************** Register *****************************************
  GlobalKey<FormState> formKeyRegister = GlobalKey<FormState>();
  Future<User> registerUsingEmailAndPassword(BuildContext context) async {
    User user = await FbAuth.auth
        .registerUsingEmailAndPassword(this.email, this.password);

    if (user != null) {
      UserModel userModel = UserModel(
        email: this.email,
        name: this.name,
      );

      FirebaseRepositoryAuth.firebaseRepository
          .setUserToFirestore(user, userModel);
      Get.offAll(RegisterSuccessScreen());
    }

    update();
    return user;
  }
  // ***********************************************************************************

  signOut() async {
    await FbAuth.auth.signOut();
  }

  onSubmitLogin(BuildContext context) async {
    // if (formKeyLogin.currentState.validate()) {
    //   formKeyLogin.currentState.save();

    await loginUsingEmailAndPassword(context);
    // } else {
    //   print('error');
    // }
    update();
  }

  onSubmitRegister(BuildContext context) async {
    await registerUsingEmailAndPassword(context);
    print('registerd');

    update();
  }
}
