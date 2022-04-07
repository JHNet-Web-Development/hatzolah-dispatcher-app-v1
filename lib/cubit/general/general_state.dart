part of 'general_cubit.dart';

class MainGeneralState extends Equatable{
  final String? message;
  final String? errorMessage;

  const MainGeneralState({
    this.message,
    this.errorMessage
  });

  @override
  List<Object?> get props => [message, errorMessage];
}

abstract class GeneralState extends Equatable {
  final MainGeneralState mainGeneralState;
  const GeneralState(this.mainGeneralState);

  @override
  List<Object> get props => [mainGeneralState];
}

class GeneralInitial extends GeneralState {
  const GeneralInitial() : super(const MainGeneralState());
}

class GeneralLoading extends GeneralState {
  const GeneralLoading(MainGeneralState mainGeneralState) : super(mainGeneralState);
}

class GeneralLoaded extends GeneralState {
  const GeneralLoaded(MainGeneralState mainGeneralState) : super(mainGeneralState);
}

class GeneralError extends GeneralState {
  const GeneralError(MainGeneralState mainGeneralState) : super(mainGeneralState);
}


