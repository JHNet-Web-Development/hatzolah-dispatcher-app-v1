import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/models/call.dart';
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

  getNewCalls() {
    try {
      _callRepository.getNewCallsStream().listen((QuerySnapshot<Call?> snapshot) async {
        emit(CallsLoading(state.mainCallsState.copyWith(message: 'Get list of New Calls')));
        List<Call> newCalls = snapshot.docs.map((e) => e.data()!).toList();
        /*List<Patient> patientsInDb = [];

        if(newCalls.isNotEmpty) {
          List<String> patientIds = [];

          for (var i = 0; i < newCalls.length; i++)
          {
            patientIds.add(newCalls[i].patientId);
          }

          if(patientIds.isNotEmpty) {
            _patientRepository.getPatientsStream(patientIds).listen((QuerySnapshot<Patient?> snapshot) async {
              patientsInDb = snapshot.docs.map((e) => e.data()!).toList();
            });
          }
        }

        if(patientsInDb.isNotEmpty){
          for (var i = 0; i < newCalls.length; i++)
          {
            for (var j = 0; j < patientsInDb.length; j++)
            {
              if(newCalls[i].patientId == patientsInDb[j].id){
                newCalls[i].patient = patientsInDb[j];
              }
            }
          }
        }*/

        emit(CallsLoaded(state.mainCallsState.copyWith(message: "Loaded New Calls", newCalls: newCalls)));
      });
    } catch (error) {
      emit(CallsError(state.mainCallsState.copyWith(message: 'Failed loading New Calls')));
    }
  }

  getUserCalls() {
    try {
      _callRepository.getUserCallsStream().listen((QuerySnapshot<Call?> snapshot) async {
        emit(CallsLoading(state.mainCallsState.copyWith(message: 'Get list of User Calls')));
        List<Call> userCalls = snapshot.docs.map((e) => e.data()!).toList();
        emit(CallsLoaded(state.mainCallsState.copyWith(message: "Loaded User Calls", userCalls: userCalls)));
      });
    } catch (error) {
      emit(CallsError(state.mainCallsState.copyWith(message: 'Failed loading User Calls')));
    }
  }
}
