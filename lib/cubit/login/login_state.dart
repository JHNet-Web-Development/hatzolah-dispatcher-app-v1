part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? message;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.message,
  });

  @override
  List<Object?> get props => [email, password, status, message];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? message,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}

class LoginStatePasswordResetSuccess extends LoginState {}
