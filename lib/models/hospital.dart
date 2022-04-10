import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Hospital extends Equatable{
  final String id;
  final String name;
  final Timestamp createdDate;
  final Timestamp? updatedDate;

  const Hospital({required this.id, required this.name, required this.createdDate, this.updatedDate});

  @override
  List<Object?> get props => [id, name, createdDate, updatedDate];

  Hospital copyWith({
    String? id,
    String? name,
    Timestamp? createdDate,
    Timestamp? updatedDate,
  }) {
    return Hospital(
      id: id ?? this.id,
      name: name ?? this.name,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
    };
  }

  factory Hospital.fromMap(Map<String, dynamic> map) {
    return Hospital(
      id: map['id'] as String,
      name: map['name'] as String,
      createdDate: map['createdDate'] as Timestamp,
      updatedDate: map['updatedDate'] as Timestamp,
    );
  }
}