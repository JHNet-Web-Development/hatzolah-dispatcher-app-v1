import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(const GeneralInitial());

  submitUserForm(String name, String surname){
    emit(GeneralLoading(state.mainGeneralState));
    try{
      emit(GeneralLoaded(state.mainGeneralState));
    }
    catch(error){
      emit(GeneralError(state.mainGeneralState));
    }

  }
}
