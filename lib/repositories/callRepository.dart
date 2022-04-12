import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/cubit/authentication/authentication_cubit.dart';
import 'package:hatzolah_dispatcher_app/models/call.dart';
import 'package:hatzolah_dispatcher_app/models/natureEmergencyConfig.dart';

class CallRepository{
  static final FirebaseFirestore _firebaseFirestore = sl<FirebaseFirestore>();

  final CollectionReference<Call?> _callsCollection = _firebaseFirestore.collection('calls').withConverter<Call?>(
    fromFirestore: (snapshot, _) => snapshot.data() != null ? Call.fromMap(snapshot.data()!) : null,
    toFirestore: (call, _) => call!.toMap(),
  );

  final AuthenticationCubit _authenticationCubit = sl<AuthenticationCubit>();

  createUpdateCall(Call call) {
    _callsCollection.doc(call.id).set(call, SetOptions(merge: true));
  }

  Stream<QuerySnapshot<Call?>> getUserCallsStream() {
    if(_authenticationCubit.state.mainAuthenticationState.user == null || _authenticationCubit.state.mainAuthenticationState.user?.id == null || _authenticationCubit.state.mainAuthenticationState.user?.id == ""){
      throw 'User not found.';
    }
    try{
      return _callsCollection.where('userId', isEqualTo: 'LnOoUagCqSeFimMXgAcDZdwXMnB3').snapshots();
    } catch(error) {
      throw 'Error ${error.toString()}';
    }
  }

  Stream<QuerySnapshot<Call?>> getNewCallsStream() {
    try{
      return _callsCollection.where('userId', isNull: true).snapshots();
    } catch(error) {
      throw 'Error ${error.toString()}';
    }
  }

 Future<List<NatureEmergencyConfig>> getNatureEmergencyConfigs() async {
  List<NatureEmergencyConfig> configList = [
    const NatureEmergencyConfig(id: 1, name: "Abdominal Pain"),
    const NatureEmergencyConfig(id: 2, name: "Bites and stings"),
  ];
  return configList;
  }

}