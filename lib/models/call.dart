import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hatzolah_dispatcher_app/models/callPatientVitals.dart';
import 'package:hatzolah_dispatcher_app/models/patient.dart';

class Call extends Equatable{
  final String id;
  final String patientId;
  final Patient patient;
  final CallPatientVitals? patientVitals;
  final String? userId;

  final Timestamp createdDate;

  const Call({required this.id, required this.patientId, required this.patient, this.patientVitals ,required this.userId, required this.createdDate});

  @override
  List<Object?> get props => [id, patientId, patient, patientVitals, userId, createdDate];

  Call copyWith({
    String? id,
    String? patientId,
    Patient? patient,
    CallPatientVitals? patientVitals,
    String? userId,
    Timestamp? createdDate,
  }) {
    return Call(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patient: patient ?? this.patient,
      patientVitals: patientVitals ?? this.patientVitals,
      userId: userId ?? this.userId,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'patient': patient.toMap(),
      'patientVitals': patientVitals != null ? patientVitals?.toMap() : patientVitals,
      'userId': userId,
      'createdDate': createdDate,
    };
  }

  factory Call.fromMap(Map<String, dynamic> map) {
    return Call(
      id: map['id'],
      patientId: map['patientId'],
      patient: map['patient'] != null ? Patient.fromMap(map['patient']) : map['patient'],
      patientVitals: map['patientVitals'] != null ? CallPatientVitals.fromMap(map['patientVitals']) : map['patientVitals'],
      userId: map['userId'],
      createdDate: map['createdDate'],
    );
  }
}