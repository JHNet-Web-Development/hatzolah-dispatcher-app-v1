import 'package:equatable/equatable.dart';

class CallPatientVitals extends Equatable{
  final double? bloodPressure;
  final double? temperature;

  const CallPatientVitals({this.bloodPressure, this.temperature});

  @override
  List<Object?> get props => [bloodPressure, temperature];

  CallPatientVitals copyWith({
    double? bloodPressure,
    double? temperature,
  }) {
    return CallPatientVitals(
      bloodPressure: bloodPressure ?? this.bloodPressure,
      temperature: temperature ?? this.temperature,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bloodPressure': bloodPressure,
      'temperature': temperature,
    };
  }

  factory CallPatientVitals.fromMap(Map<String, dynamic> map) {
    return CallPatientVitals(
      bloodPressure: map['bloodPressure'],
      temperature: map['temperature'],
    );
  }
}