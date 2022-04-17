import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hatzolah_dispatcher_app/models/callPatientVitals.dart';
import 'package:hatzolah_dispatcher_app/models/patient.dart';
import 'package:hatzolah_dispatcher_app/models/question-models/abdominal-pain-questions.dart';
import 'package:hatzolah_dispatcher_app/models/question-models/bites-and-stings-questions.dart';

class Call extends Equatable{
  final String id;
  final String patientId;
  final Patient patient;
  final CallPatientVitals? patientVitals;
  final int questionType;
  final dynamic questions;
  final String? userId;
  final Timestamp createdDate;

  const Call({required this.id, required this.patientId, required this.patient, this.patientVitals, required this.questionType, required this.questions ,required this.userId, required this.createdDate});

  @override
  List<Object?> get props => [id, patientId, patient, questionType, questions, patientVitals, userId, createdDate];

  Call copyWith({
    String? id,
    String? patientId,
    Patient? patient,
    CallPatientVitals? patientVitals,
    int? questionType,
    dynamic questions,
    String? userId,
    Timestamp? createdDate,
  }) {
    return Call(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patient: patient ?? this.patient,
      patientVitals: patientVitals ?? this.patientVitals,
      questionType : questionType ?? this.questionType,
      questions: questions ?? this.questions,
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
      'questionType': questionType,
      'questions': questions != null ? questions?.toMap() : questions,
      'userId': userId,
      'createdDate': createdDate,
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
      patientId: map['patientId'],
      patient: map['patient'] != null ? Patient.fromMap(map['patient']) : map['patient'],
      patientVitals: map['patientVitals'] != null ? CallPatientVitals.fromMap(map['patientVitals']) : map['patientVitals'],
      questionType: map['questionType'],
      questions: map['questions'] != null ?  questionMapType: map['questions'],
      userId: map['userId'],
      createdDate: map['createdDate'],
    );
  }
}