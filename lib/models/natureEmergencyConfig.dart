import 'package:equatable/equatable.dart';
import 'package:hatzolah_dispatcher_app/models/natureEmergencyQuestion.dart';

class NatureEmergencyConfig extends Equatable{
  final int? id;
  final String? name;

 const NatureEmergencyConfig({this.id, this.name});


  NatureEmergencyConfig copyWith({
    int? id,
    String? name,
  }) {
    return NatureEmergencyConfig(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
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
    );
  }
}