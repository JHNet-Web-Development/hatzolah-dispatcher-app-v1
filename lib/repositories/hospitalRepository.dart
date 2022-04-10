import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/models/call.dart';
import 'package:hatzolah_dispatcher_app/models/hospital.dart';

class HospitalRepository{
  static final FirebaseFirestore _firebaseFirestore = sl<FirebaseFirestore>();

  final CollectionReference<Hospital?> _hospitalCollection = _firebaseFirestore.collection('hospitals').withConverter<Hospital?>(
    fromFirestore: (snapshot, _) => snapshot.data() != null ? Hospital.fromMap(snapshot.data()!) : null,
    toFirestore: (call, _) => call!.toMap(),
  );

  createUpdateHospital(Hospital hospital) {
    _hospitalCollection.doc(hospital.id).set(hospital, SetOptions(merge: true));
  }

  Stream<QuerySnapshot<Hospital?>> getHospitalStream() {
    try{
      return _hospitalCollection.snapshots();
    } catch(error) {
      throw 'Error ${error.toString()}';
    }
  }
}