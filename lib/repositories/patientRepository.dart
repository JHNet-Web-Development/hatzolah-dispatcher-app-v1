import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/models/patient.dart';

class PatientRepository{
  static final FirebaseFirestore _firebaseFirestore = sl<FirebaseFirestore>();

  final CollectionReference<Patient?> _callsCollection = _firebaseFirestore.collection('patients').withConverter<Patient?>(
    fromFirestore: (snapshot, _) => snapshot.data() != null ? Patient.fromMap(snapshot.data()!) : null,
    toFirestore: (call, _) => call!.toMap(),
  );

  Stream<QuerySnapshot<Patient?>> getPatientsStream(List<String> patientIds) {
    try{
      return _callsCollection.where('id', whereIn: patientIds).snapshots();
    } catch(error) {
      throw 'Error ${error.toString()}';
    }
  }
}