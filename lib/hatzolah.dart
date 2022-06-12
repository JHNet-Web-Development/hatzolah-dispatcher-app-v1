import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatzolah_dispatcher_app/constants/themes.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/authentication/authentication_cubit.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/home.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/login/login_screen.dart';
import 'package:hatzolah_dispatcher_app/ui/screens/splash.dart';

class Hatzolah extends StatefulWidget {
  const Hatzolah({Key? key}) : super(key: key);

  @override
  State<Hatzolah> createState() => _HatzolahState();
}

class _HatzolahState extends State<Hatzolah> {
  final AuthenticationCubit _authenticationCubit = sl<AuthenticationCubit>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: HatzolahTheme.mainTheme(context),
      home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        bloc: _authenticationCubit,
        builder: (context, state) {
          if(state is Uninitialized){
            return SplashScreen();
          }
          if(state is Unauthenticated){
            return LoginScreen();
          }
          if(state is Authenticated){
            return HomeScreen();
          }

          return LoginScreen();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
