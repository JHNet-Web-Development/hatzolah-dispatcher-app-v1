part of 'calls_cubit.dart';


class MainCallsState extends Equatable {
  final String? message;
  final String? errorMessage;
  final List<Call> userCalls;
  final List<Call> newCalls;
  final List<NatureEmergencyConfig> configs;
  final List<Patient> patients;

  const MainCallsState({this.message, this.errorMessage, this.userCalls = const [], this.newCalls = const [], this.configs = const [], this.patients = const []});

  @override
  List<Object?> get props => [message, errorMessage, userCalls, newCalls, configs, patients];

  MainCallsState copyWith({
    String? message,
    String? errorMessage,
    List<Call>? userCalls,
    List<Call>? newCalls,
    List<NatureEmergencyConfig>? configs,
    List<Patient>? patients,
  }) {
    return MainCallsState(
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
      userCalls: userCalls ?? this.userCalls,
      newCalls: newCalls ?? this.newCalls,
      configs: configs ?? this.configs,
      patients: patients ?? this.patients,
    );
  }
}

abstract class CallsState extends Equatable {
  final MainCallsState mainCallsState;
  const CallsState(this.mainCallsState);


  @override
  List<Object?> get props => [mainCallsState];
}


class CallsInitial extends CallsState {
  const CallsInitial() : super(const MainCallsState());
}

class CallsLoading extends CallsState {
  const CallsLoading(MainCallsState mainCallsState) : super(mainCallsState);
}

class CallsLoaded extends CallsState {
  const CallsLoaded(MainCallsState mainCallsState) : super(mainCallsState);
}

class CallUpdated extends CallsState {
  const CallUpdated(MainCallsState mainCallsState) : super(mainCallsState);
}

class CallCreated extends CallsState {
  const CallCreated(MainCallsState mainCallsState) : super(mainCallsState);
}

class CallsError extends CallsState {
  const CallsError(MainCallsState mainCallsState) : super(mainCallsState);
}