import 'package:equatable/equatable.dart';
import 'package:hatzolah_dispatcher_app/models/natureEmergencyQuestion.dart';

class NatureEmergencyConfig extends Equatable{
  final String? id;
  final String? name;
  final List<NatureEmergencyQuestion>? questions;

 const NatureEmergencyConfig({this.id, this.name, this.questions});


  NatureEmergencyConfig copyWith({
    String? id,
    String? name,
    List<NatureEmergencyQuestion>? questions,
  }) {
    return NatureEmergencyConfig(
      id: id ?? this.id,
      name: name ?? this.name,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object?> get props => [id, name, questions];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'questions': questions?.map((e) => e.toMap()).toList(),
    };
  }

  factory NatureEmergencyConfig.fromMap(Map<String, dynamic> map) {
    List<NatureEmergencyQuestion> _natureEmergencyQuestions = [];

    map['questions']?.forEach((question) {
      _natureEmergencyQuestions.add(NatureEmergencyQuestion.fromMap(question));
    });

    return NatureEmergencyConfig(
      id: map['id'],
      name: map['name'],
      questions: _natureEmergencyQuestions,
    );
  }
}