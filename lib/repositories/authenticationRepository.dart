

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hatzolah_dispatcher_app/core/dependencies.dart';
import 'package:hatzolah_dispatcher_app/models/firebase_user.dart';
import 'package:hatzolah_dispatcher_app/models/tp_firebase_user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = sl<FirebaseAuth>();
  static final FirebaseFirestore _firebaseFirestore = sl<FirebaseFirestore>();

  final CollectionReference<FirebaseUser?> _userRefCollection = _firebaseFirestore.collection('users').withConverter<FirebaseUser?>(
    fromFirestore: (snapshot, _) => snapshot.data() != null ? FirebaseUser.fromMap(snapshot.data()!, snapshot.id) : null,
    toFirestore: (authProviderUserDetails, _) => authProviderUserDetails!.toMap(),
  );

  Future<FirebaseUser?> loadUserFromPrefs({User? currentUser}) async {
    // Check if user param is null
    if (currentUser == null)
    {
      // Get Firebase Authentication User
      currentUser = _firebaseAuth.currentUser;

      // Check if Firebase Authentication User is null
      if (currentUser == null)
      {
          return null;
      }
    }

    // Get User from Firebase User Collection
    FirebaseUser? user = await loadUserFromFirebase(currentUser);
    return user;
  }

  Future<FirebaseUser?> loadUserFromFirebase(User currentUser) async {
    DocumentSnapshot<FirebaseUser?> snap = await _userRefCollection.doc(currentUser.uid).get();
    if (snap.data() != null) {
      FirebaseUser userDetails = snap.data()!;
      return userDetails;
    } else {
      Map<String, dynamic> user = FirebaseUser.firebaseMetadataToMap(currentUser);
      await _userRefCollection.doc(currentUser.uid).set(FirebaseUser.fromMap(user, currentUser.uid), SetOptions(merge: true));
      return loadUserFromFirebase(currentUser);
    }
  }

  Future<TPFirebaseUser> signInWithEmailPassword({required String email, required String password, bool linkCredential = false}) async {
    try {
      UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return TPFirebaseUser(authResult.user, null);
    } on FirebaseAuthException catch (error) {
      return TPFirebaseUser(null, error);
    } catch (error) {
      return TPFirebaseUser(null, error);
    }
  }

  Future<void> signOut({bool clearPreferences = false}) async {
    try {
      SharedPreferences preferences = await sl.getAsync<SharedPreferences>();
      preferences.remove('userDetails');

      if (clearPreferences) {
        preferences.clear();
      }

    } catch (error) {
      rethrow;
    }
  }
}