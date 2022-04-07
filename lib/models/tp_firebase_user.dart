import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TPFirebaseUser extends Equatable {
  final User? user;
  final dynamic error;

  const TPFirebaseUser(this.user, this.error);

  @override
  List<Object?> get props => [user, error];
}

class TPVerificationId extends Equatable {
  final User? user;
  final String? verificationId;
  final FirebaseAuthException? error;

  const TPVerificationId(this.user, this.verificationId, this.error);

  @override
  List<Object?> get props => [user, verificationId, error];
}