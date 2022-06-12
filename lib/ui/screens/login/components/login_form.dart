import 'package:flutter/material.dart';
import 'package:hatzolah_dispatcher_app/constants/forms.dart';
import 'package:hatzolah_dispatcher_app/size_config.dart';
import 'package:hatzolah_dispatcher_app/ui/buttons/default_button.dart';
import 'package:hatzolah_dispatcher_app/ui/icons/custom_surffix_icon.dart';
import 'package:hatzolah_dispatcher_app/ui/keyboard/keyboard.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/home.dart';
import 'package:hatzolah_dispatcher_app/utilities/forms/form_error.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: PassNullErrorText);
        } else if (value.length >= 8) {
          removeError(error: ShortPassErrorText);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: PassNullErrorText);
          return "";
        } else if (value.length < 8) {
          addError(error: ShortPassErrorText);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: EmailNullErrorText);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: InvalidEmailErrorText);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: EmailNullErrorText);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: InvalidEmailErrorText);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
