import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("تسجيل حساب", style: headingStyle),
                Text(
                  "أدخل التفاصيل الخاصة بك",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                // Consumer<AuthProvider>(
                //   builder: (context, provider, child) =>
                SignUpForm(),
                // ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  'من خلال إنشاء حساب ، فإنك توافق على\n بنود الخدمة وخصوصية السياسة',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
