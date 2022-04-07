import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/models/call.dart';

class CallRepository{
  static final FirebaseFirestore _firebaseFirestore = sl<FirebaseFirestore>();

  final CollectionReference<Call?> _callsCollection = _firebaseFirestore.collection('calls').withConverter<Call?>(
    fromFirestore: (snapshot, _) => snapshot.data() != null ? Call.fromMap(snapshot.data()!) : null,
    toFirestore: (call, _) => call!.toMap(),
  );

  createUpdateCall(Call call) {
    _callsCollection.doc(call.id).set(call, SetOptions(merge: true));
  }

  Stream<QuerySnapshot<Call?>> getUserCallsStream() {
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

}