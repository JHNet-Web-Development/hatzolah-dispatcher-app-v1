part of 'authentication_cubit.dart';

class MainAuthenticationState extends Equatable {
  final String? message;
  final String? errorMessage;
  final FirebaseUser? user;

  const MainAuthenticationState({this.user, this.message, this.errorMessage});

  @override
  List<Object?> get props => [user, message, errorMessage];

  MainAuthenticationState copyWith({
    FirebaseUser? user,
    String? message,
    String? errorMessage,
  }) {
    if ((user == null || identical(user, this.user)) && (message == null || identical(message, this.message)) && (errorMessage == null || identical(errorMessage, this.errorMessage))) {
      return this;
    }

    return MainAuthenticationState(
        user: user ?? this.user,
        message: message ?? this.message,
        errorMessage: errorMessage ?? this.errorMessage
    );
  }
}

abstract class AuthenticationState extends Equatable {
  final MainAuthenticationState mainAuthenticationState;

  const AuthenticationState(this.mainAuthenticationState);

  @override
  List<Object> get props => [mainAuthenticationState];
}

class Uninitialized extends AuthenticationState {
  const Uninitialized() : super(const MainAuthenticationState());
}

class Authenticated extends AuthenticationState {
  const Authenticated(MainAuthenticationState mainAuthenticationState) : super(mainAuthenticationState);
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated(MainAuthenticationState mainAuthenticationState) : super(mainAuthenticationState);
}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError(MainAuthenticationState mainAuthenticationState) : super(mainAuthenticationState);
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading(MainAuthenticationState mainAuthenticationState) : super(mainAuthenticationState);
}