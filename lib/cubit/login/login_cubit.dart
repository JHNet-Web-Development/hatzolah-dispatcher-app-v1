import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/models/email.dart';
import 'package:hatzolah_dispatcher_app/models/password.dart';
import 'package:hatzolah_dispatcher_app/models/tp_firebase_user.dart';
import 'package:hatzolah_dispatcher_app/repositories/authenticationRepository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());
  final AuthenticationRepository _authenticationRepository = sl<AuthenticationRepository>();

  loginWithEmailPasswordPressed({required String email,required String password}) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      TPFirebaseUser user = await _authenticationRepository.signInWithEmailPassword(email: email, password:password);
      continueLogin(user);
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, message: error.message));
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, message: error.toString()));
    }
  }

  continueLogin(TPFirebaseUser user) {
    if (user.user != null && user.error == null) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } else {
      emit(state.copyWith(status: FormzStatus.submissionFailure, message: user.error.message));
    }
  }
}
