import 'package:equatable/equatable.dart';

class AbdominalPainQuestions extends Equatable{

  final bool patientAlert;
  final bool troubleBreathing;
  final bool bleeding;
  final bool dizzyOrFaint;
  final bool pale;
  final bool chestPain;
  final bool recentSurgery;
  final bool recentVomiting;

  const AbdominalPainQuestions({required this.patientAlert, required this.troubleBreathing, required this.bleeding, required this.dizzyOrFaint, required this.pale ,required this.chestPain, required this.recentSurgery, required this.recentVomiting});

  @override
  // TODO: implement props
  List<Object?> get props => [patientAlert, troubleBreathing, bleeding, dizzyOrFaint, pale, chestPain, recentSurgery, recentVomiting];

  Map<String, dynamic> toMap() {
    return {
      'patientAlert': patientAlert,
      'troubleBreathing': troubleBreathing,
      'bleeding': bleeding,
      'dizzyOrFaint': dizzyOrFaint,
      'pale': pale,
      'chestPain': chestPain,
      'recentSurgery': recentSurgery,
      'recentVomiting': recentVomiting,
    };
  }

  factory AbdominalPainQuestions.fromMap(Map<String, dynamic> map) {
    return AbdominalPainQuestions(
      patientAlert: map['patientAlert'],
      troubleBreathing: map['troubleBreathing'],
      bleeding: map['bleeding'],
      dizzyOrFaint: map['dizzyOrFaint'],
      pale: map['pale'],
      chestPain: map['chestPain'],
      recentSurgery: map['recentSurgery'],
      recentVomiting: map['recentVomiting'],
    );
  }
}