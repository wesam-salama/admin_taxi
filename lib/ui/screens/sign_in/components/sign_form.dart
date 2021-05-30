import 'package:admin_app/get/getx_state.dart';
import 'package:admin_app/ui/components/custom_surfix_icon.dart';
import 'package:admin_app/ui/components/form_error.dart';
import 'package:admin_app/ui/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../../components/default_button.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  // final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthGet>(
      builder: (controler) {
        return Form(
          key: controler.formKeyLogin,
          child: Column(
            children: [
              buildEmailFormField(controler),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPasswordFormField(controler),
              SizedBox(height: getProportionateScreenHeight(30)),
              Row(
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () => Get.to(ForgotPasswordScreen()),
                    child: Text(
                      "نسيت كلمة المرور",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(20)),
              DefaultButton(
                text: "تسجيل الدخول",
                press: () {
                  if (controler.formKeyLogin.currentState.validate()) {
                    controler.formKeyLogin.currentState.save();
                    controler.onSubmitLogin(context);
                    print(email);
                    print(password);

                    // if all are valid then go to success screen

                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  TextFormField buildPasswordFormField(AuthGet controler) {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => controler.password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "كلمة المرور",
        hintText: "أدخل كلمة المرور",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField(AuthGet controler) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => controler.email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "البريد الإلكتروني",
        hintText: "أدخل البريد الإلكتروني",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
        ),
      ),
    );
  }
}
