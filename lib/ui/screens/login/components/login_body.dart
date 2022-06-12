import 'package:flutter/material.dart';
import 'package:hatzolah_dispatcher_app/size_config.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/login/components/login_form.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

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
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Image.asset(
                  'assets/images/hatzolah-logo-full.png',
                  width: getProportionateScreenWidth(235),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                const Text(
                  "Sign in with your email and password",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                const LoginForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}