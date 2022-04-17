import 'package:equatable/equatable.dart';

class BitesAndStingsQuestions extends Equatable{

  final bool patientAlert;
  final bool troubleBreathing;
  final bool troubleSwallowing;
  final bool tightnessThroatOrChest;
  final bool dizzyFaintOrSweaty;
  final bool pale;
  final bool historyAllergicReactions;

  const BitesAndStingsQuestions({required this.patientAlert, required this.troubleBreathing, required this.troubleSwallowing, required this.tightnessThroatOrChest, required this.dizzyFaintOrSweaty ,required this.pale, required this.historyAllergicReactions});

  @override
  // TODO: implement props
  List<Object?> get props => [patientAlert, troubleBreathing, troubleSwallowing, tightnessThroatOrChest, dizzyFaintOrSweaty, pale, historyAllergicReactions];

  Map<String, dynamic> toMap() {
    return {
      'patientAlert': patientAlert,
      'troubleBreathing': troubleBreathing,
      'troubleSwallowing': troubleSwallowing,
      'tightnessThroatOrChest': tightnessThroatOrChest,
      'dizzyFaintOrSweaty': dizzyFaintOrSweaty,
      'pale': pale,
      'historyAllergicReactions': historyAllergicReactions,
    };
  }

  factory BitesAndStingsQuestions.fromMap(Map<String, dynamic> map) {
    return BitesAndStingsQuestions(
      patientAlert: map['patientAlert'],
      troubleBreathing: map['troubleBreathing'],
      troubleSwallowing: map['troubleSwallowing'],
      tightnessThroatOrChest: map['tightnessThroatOrChest'],
      dizzyFaintOrSweaty: map['dizzyFaintOrSweaty'],
      pale: map['pale'],
      historyAllergicReactions: map['historyAllergicReactions'],
    );
  }
}