import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/models/call.dart';
import 'package:hatzolah_dispatcher_app/models/natureEmergencyConfig.dart';
import 'package:hatzolah_dispatcher_app/models/patient.dart';
import 'package:hatzolah_dispatcher_app/repositories/callRepository.dart';
import 'package:hatzolah_dispatcher_app/repositories/patientRepository.dart';

part 'calls_state.dart';

class CallsCubit extends Cubit<CallsState> {
  CallsCubit() : super(const CallsInitial());
  final CallRepository _callRepository = sl<CallRepository>();
  final PatientRepository _patientRepository = sl<PatientRepository>();

  createUpdateCall(Call call) {
    emit(CallsLoading(state.mainCallsState.copyWith(message: 'Creating Call')));
    try {
      _callRepository.createUpdateCall(call);
      emit(CallUpdated(state.mainCallsState.copyWith(message: 'Call Updated')));
    } catch (error) {
      emit(CallsError(state.mainCallsState
          .copyWith(errorMessage: 'Failed creating call', message: '')));
    }
  }

  getCalls() {
    try {
      _callRepository.getCallsStream().listen((QuerySnapshot<Call?> snapshot) async {
        emit(CallsLoading(state.mainCallsState.copyWith(message: 'Get list of User Calls')));
        List<Call> calls = snapshot.docs.map((e) => e.data()!).toList();
        emit(CallsLoaded(state.mainCallsState.copyWith(message: "Loaded User Calls", calls: calls)));
      });
    } catch (error) {
      emit(CallsError(state.mainCallsState.copyWith(message: 'Failed loading User Calls')));
    }
  }

  getNatureEmergencyConfigs() async{
    try {
      emit(CallsLoading(state.mainCallsState.copyWith(message: 'Get list of Emergency nature configs')));
      List<NatureEmergencyConfig> configs = await _callRepository.getNatureEmergencyConfigs();
      emit(CallsLoaded(state.mainCallsState.copyWith(message: "Loaded Emergency nature configs", configs: configs)));
    } catch (error) {
      emit(CallsError(state.mainCallsState.copyWith(message: 'Failed loading Emergency nature configs')));
    }
  }

  getAllPatients() async{
    try {
      emit(CallsLoading(state.mainCallsState.copyWith(message: 'Patients Loading')));
      List<Patient> patients = await _patientRepository.getAllPatients();
      emit(CallsLoaded(state.mainCallsState.copyWith(message: "Patients Loaded", patients: patients)));
    } catch (error) {
      emit(CallsError(state.mainCallsState.copyWith(message: 'Failed loading Patients')));
    }
  }
}
