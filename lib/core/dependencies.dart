import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hatzolah_dispatcher_app/cubit/authentication/authentication_cubit.dart';
import 'package:hatzolah_dispatcher_app/cubit/calls/calls_cubit.dart';
import 'package:hatzolah_dispatcher_app/cubit/general/general_cubit.dart';
import 'package:hatzolah_dispatcher_app/cubit/hospital/hospital_cubit.dart';
import 'package:hatzolah_dispatcher_app/cubit/login/login_cubit.dart';
import 'package:hatzolah_dispatcher_app/repositories/authenticationRepository.dart';
import 'package:hatzolah_dispatcher_app/repositories/callRepository.dart';
import 'package:hatzolah_dispatcher_app/repositories/hospitalRepository.dart';
import 'package:hatzolah_dispatcher_app/repositories/patientRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

class DependencyInjection{
  Future<void> init() async{
    await Firebase.initializeApp();
    await _repos();
    await _cubits();
    await _main();
  }

  static _main() {
    if (!sl.isRegistered<FirebaseAuth>()) sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    if (!sl.isRegistered<FirebaseFirestore>()) sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    if (!sl.isRegistered<SharedPreferences>()) sl.registerLazySingletonAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());
  }

  static _repos() {
    sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepository());
    sl.registerLazySingleton<CallRepository>(() => CallRepository());
    sl.registerLazySingleton<PatientRepository>(() => PatientRepository());
    sl.registerLazySingleton<HospitalRepository>(() => HospitalRepository());
  }

  static _cubits(){
    sl.registerLazySingleton<GeneralCubit>(() => GeneralCubit());
    sl.registerLazySingleton<LoginCubit>(() => LoginCubit());
    sl.registerLazySingleton<CallsCubit>(() => CallsCubit());
    sl.registerLazySingleton<HospitalCubit>(() => HospitalCubit());
    sl.registerLazySingleton<AuthenticationCubit>(() => AuthenticationCubit()..appStarted());
  }
}
