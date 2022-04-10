part of 'hospital_cubit.dart';

class MainHospitalState extends Equatable{
  final String? message;
  final String? errorMessage;
  final List<Hospital> hospitals;

  const MainHospitalState({this.message, this.errorMessage, this.hospitals = const []});

  @override
  List<Object?> get props => [message, errorMessage, hospitals,];

  MainHospitalState copyWith({
    String? message,
    String? errorMessage,
    List<Hospital>? hospitals
  }) {
    return MainHospitalState(
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
      hospitals: hospitals ?? this.hospitals,
    );
  }
}

abstract class HospitalState extends Equatable {
  final MainHospitalState mainHospitalState;
  const HospitalState(this.mainHospitalState);


  @override
  List<Object?> get props => [mainHospitalState];
}


class HospitalInitial extends HospitalState {
  const HospitalInitial() : super(const MainHospitalState());
}

class HospitalLoading extends HospitalState {
  const HospitalLoading(MainHospitalState mainHospitalState) : super(mainHospitalState);
}

class HospitalLoaded extends HospitalState {
  const HospitalLoaded(MainHospitalState mainHospitalState) : super(mainHospitalState);
}

class HospitalUpdated extends HospitalState {
  const HospitalUpdated(MainHospitalState mainHospitalState) : super(mainHospitalState);
}

class HospitalError extends HospitalState {
  const HospitalError(MainHospitalState mainHospitalState) : super(mainHospitalState);
}
