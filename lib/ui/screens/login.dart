import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hatzolah_dispatcher_app/constants/constants.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/authentication/authentication_cubit.dart';
import 'package:hatzolah_dispatcher_app/cubit/login/login_cubit.dart';
import 'package:hatzolah_dispatcher_app/utilities/hex_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final LoginCubit _loginCubit = sl<LoginCubit>();
  final AuthenticationCubit _authenticationCubit = sl<AuthenticationCubit>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc:_loginCubit ,
  listener: (context, state) {
    if (state.status.isSubmissionFailure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Row(children: [Expanded(child: Text(state.message ?? '')), const Icon(Icons.error)]), backgroundColor: Colors.red));
    }

    if (state.status.isSubmissionInProgress) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Logging In...'),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
    }

    if (state.status.isSubmissionSuccess) {
      _authenticationCubit.loggedIn();
    }
  },
  child: Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width/1.2,
          height: MediaQuery.of(context).size.height/4,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Text is empty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: surnameController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Text is empty';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () => _loginCubit.loginWithEmailPasswordPressed(email: nameController.text.trim(), password: surnameController.text.trim()),
                    child: const Text("Submit"),
                    style: ElevatedButton.styleFrom(
                      primary: primaryColour,
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
);
  }
}
