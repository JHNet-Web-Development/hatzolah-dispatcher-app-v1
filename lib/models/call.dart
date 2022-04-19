import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hatzolah_dispatcher_app/models/callPatientVitals.dart';
import 'package:hatzolah_dispatcher_app/models/patient.dart';
import 'package:hatzolah_dispatcher_app/models/question-models/abdominal-pain-questions.dart';
import 'package:hatzolah_dispatcher_app/models/question-models/bites-and-stings-questions.dart';

class Call extends Equatable{
  final String id;
  final Patient patient;
  final String address;
  final CallPatientVitals? patientVitals;
  final int questionType;
  final dynamic questions;
  final String? userId;
  final int status;
  final Timestamp dispatchedDate;
  final Timestamp? acceptedDate;
  final Timestamp? arrivedDate;
  final Timestamp? closedDate;

  const Call({required this.id, required this.patient, required this.address, this.patientVitals, required this.questionType, required this.questions ,required this.userId, required this.status, required this.dispatchedDate, this.acceptedDate, this.arrivedDate, this.closedDate});

  @override
  List<Object?> get props => [id, patient, address, questionType, questions, patientVitals, userId, status, dispatchedDate, acceptedDate, arrivedDate, closedDate];

  Call copyWith({
    String? id,
    Patient? patient,
    String? address,
    CallPatientVitals? patientVitals,
    int? questionType,
    dynamic questions,
    String? userId,
    int? status,
    Timestamp? dispatchedDate,
    Timestamp? acceptedDate,
    Timestamp? arrivedDate,
    Timestamp? closedDate,
  }) {
    return Call(
      id: id ?? this.id,
      patient: patient ?? this.patient,
      address: address ?? this.address,
      patientVitals: patientVitals ?? this.patientVitals,
      questionType : questionType ?? this.questionType,
      questions: questions ?? this.questions,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      dispatchedDate: dispatchedDate ?? this.dispatchedDate,
      acceptedDate: acceptedDate ?? this.acceptedDate,
      arrivedDate: arrivedDate ?? this.arrivedDate,
      closedDate: closedDate ?? this.closedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient': patient.toMap(),
      'address': address,
      'patientVitals': patientVitals != null ? patientVitals?.toMap() : patientVitals,
      'questionType': questionType,
      'questions': questions != null ? questions?.toMap() : questions,
      'userId': userId,
      'status': status,
      'dispatchedDate': dispatchedDate,
      'acceptedDate': acceptedDate,
      'arrivedDate': arrivedDate,
      'closedDate': closedDate,
    };
  }

  factory Call.fromMap(Map<String, dynamic> map) {
    var questionMapType;

    switch (map['questionType']) {
      case 0:
        questionMapType = AbdominalPainQuestions.fromMap(map['questions']);
        break;
      case 1:
        questionMapType = BitesAndStingsQuestions.fromMap(map['questions']);
        break;
    }

    return Call(
      id: map['id'],
      patient: map['patient'] != null ? Patient.fromMap(map['patient']) : map['patient'],
      address: map['address'],
      patientVitals: map['patientVitals'] != null ? CallPatientVitals.fromMap(map['patientVitals']) : map['patientVitals'],
      questionType: map['questionType'],
      questions: map['questions'] != null ?  questionMapType: map['questions'],
      userId: map['userId'],
      status: map['status'],
      dispatchedDate: map['dispatchedDate'],
      acceptedDate: map['acceptedDate'],
      arrivedDate: map['arrivedDate'],
      closedDate: map['closedDate'],
    );
  }
}