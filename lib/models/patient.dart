import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Patient extends Equatable{
  final String id;
  final String firstName;
  final String lastName;
  final Timestamp createdDate;

  const Patient({required this.id, required this.firstName, required this.lastName, required this.createdDate});

  @override
  List<Object?> get props => [id, firstName, lastName, createdDate];

  Patient copyWith({
    String? id,
    String? firstName,
    String? lastName,
    Timestamp? createdDate,
  }) {
    return Patient(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'createdDate': createdDate,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      createdDate: map['createdDate'] as Timestamp,
    );
  }
}