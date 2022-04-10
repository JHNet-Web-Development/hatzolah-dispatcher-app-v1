import 'package:equatable/equatable.dart';

class NatureEmergencyQuestion extends Equatable {
  final String? questionText;
  final int? questionType;

 const NatureEmergencyQuestion({this.questionText, this.questionType});

  NatureEmergencyQuestion copyWith({
    String? questionText,
    int? questionType,
  }) {
    return NatureEmergencyQuestion(
      questionText: questionText ?? this.questionText,
      questionType: questionType ?? this.questionType,
    );
  }

  @override
  List<Object?> get props => [questionText, questionType];

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'questionType': questionType,
    };
  }

  factory NatureEmergencyQuestion.fromMap(Map<String, dynamic> map) {
    return NatureEmergencyQuestion(
      questionText: map['questionText'],
      questionType: map['questionType'],
    );
  }
}