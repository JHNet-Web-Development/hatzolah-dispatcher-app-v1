import 'package:flutter/material.dart';
import 'package:hatzolah_dispatcher_app/size_config.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/login/components/login_body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: LoginBody(),
    );
  }
}
