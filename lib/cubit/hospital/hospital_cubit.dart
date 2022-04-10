import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/models/hospital.dart';
import 'package:hatzolah_dispatcher_app/repositories/hospitalRepository.dart';

part 'hospital_state.dart';

class HospitalCubit extends Cubit<HospitalState> {
  HospitalCubit() : super(HospitalInitial());

  final HospitalRepository _hospitalRepository = sl<HospitalRepository>();

  createUpdateHospital(Hospital hospital) {
    emit(HospitalLoading(state.mainHospitalState.copyWith(message: 'Creating and/or updating hospital')));
    try {
      _hospitalRepository.createUpdateHospital(hospital);
      emit(HospitalUpdated(state.mainHospitalState.copyWith(message: 'Hospital Updated')));
    } catch (error) {
      emit(HospitalError(state.mainHospitalState
          .copyWith(errorMessage: 'Failed creating and/or updating hospital', message: '')));
    }
  }

  getHospitals() {
    try {
      _hospitalRepository.getHospitalStream().listen((QuerySnapshot<Hospital?> snapshot) async {
        emit(HospitalLoading(state.mainHospitalState.copyWith(message: 'Get list of Hospitals')));
        List<Hospital> hospitals = snapshot.docs.map((e) => e.data()!).toList();
        emit(HospitalLoaded(state.mainHospitalState.copyWith(message: "Loaded Hospitals", hospitals: hospitals)));
      });
    } catch (error) {
      emit(HospitalError(state.mainHospitalState.copyWith(message: 'Failed loading Hospitals')));
    }
  }
}
