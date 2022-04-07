import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' as foundation;
class FirebaseUser extends Equatable {
  final String? id;
  final String? email;
  final String? devicePlatform;
  final Map<String, dynamic>? packageInfo;

  const FirebaseUser({this.id,this.email,this.devicePlatform, this.packageInfo});

  @override
  List<Object?> get props => [id, email, devicePlatform, packageInfo];

  factory FirebaseUser.fromMap(Map<String, dynamic> map, String id) {
    return FirebaseUser(
      id: id,
      email: map['email'] as String?,
      devicePlatform: map['devicePlatform'] as String?,
      packageInfo: map['packageInfo'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': id,
      'email': email,
      'devicePlatform': devicePlatform,
      'packageInfo': packageInfo,
    } as Map<String, dynamic>;
  }

  FirebaseUser copyWith({
    String? id,
    String? email,
    String? devicePlatform,
    Map<String, dynamic>? packageInfo,
  }) {
    if ((id == null || identical(id, this.id)) && (email == null || identical(email, this.email)) && (devicePlatform == null || identical(devicePlatform, this.devicePlatform)) && (packageInfo == null || identical(packageInfo, this.packageInfo))) {
      return this;
    }

    return FirebaseUser(
      id: id ?? this.id,
      email: email ?? this.email,
      devicePlatform: devicePlatform ?? this.devicePlatform,
      packageInfo: packageInfo ?? this.packageInfo,
    );
  }

 static Map<String, dynamic> firebaseMetadataToMap(User user) {
    var map = <String, dynamic>{};
    map['id'] = user.uid;
    map['email'] = user.email;
    map['phoneNumber'] = user.phoneNumber;
    map['photoUrl'] = user.photoURL;
    map['role'] = 'user';
    map['created'] = Timestamp.now();
    map['providerData'] = {};
    if (user.providerData.isNotEmpty) {
      for (var info in user.providerData) {
        map['providerData'][info.providerId] = {
          'displayName': info.displayName,
          'email': info.email,
          'phoneNumber': info.phoneNumber,
          'photoUrl': info.photoURL,
        };
      }
    }
    map['lastSeen'] = Timestamp.now();
    if (!foundation.kIsWeb) {
      map['devicePlatform'] = Platform.isIOS ? 'iOS' : 'Android';
    } else {
      map['devicePlatform'] = 'Browser';
    }

    return map;
  }
}