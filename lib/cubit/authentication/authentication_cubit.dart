import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/models/firebase_user.dart';
import 'package:hatzolah_dispatcher_app/repositories/authenticationRepository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const Uninitialized());
  final AuthenticationRepository _authRepository = sl<AuthenticationRepository>();

  appStarted() async {
    FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
    try {
      FirebaseUser? user = await _authRepository.loadUserFromPrefs();
      if (user != null) {
        emit(Authenticated(state.mainAuthenticationState.copyWith(user: user)));
      } else {
        emit(Unauthenticated(state.mainAuthenticationState.copyWith()));
      }
    } catch (error) {
      emit(const Unauthenticated(MainAuthenticationState()));
    }
  }

  loggedIn() async {
    FirebaseUser? user = await _authRepository.loadUserFromPrefs();
    if (user != null) {
      emit(Authenticated(state.mainAuthenticationState.copyWith(user: user)));
    } else {
      emit(Unauthenticated(state.mainAuthenticationState));
    }
  }

  loggedOut({bool clearPreferences = false}) {
    _authRepository.signOut(clearPreferences: clearPreferences);
    emit(const Unauthenticated(MainAuthenticationState()));
  }
}
