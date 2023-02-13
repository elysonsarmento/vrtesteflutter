import 'dart:convert';

import 'package:flutter/foundation.dart';

class Course {
  String name;
  String? descripton;
  String? id;
  List<String>? studentsId;
  Course({
    required this.name,
    this.descripton,
    this.id,
    this.studentsId,
  });

  Course copyWith({
    String? name,
    String? descripton,
    String? id,
    List<String>? studentsId,
  }) {
    return Course(
      name: name ?? this.name,
      descripton: descripton ?? this.descripton,
      id: id ?? this.id,
      studentsId: studentsId ?? this.studentsId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'descripton': descripton,
      'id': id,
      'studentsId': studentsId,
    }..removeWhere((key, value) => value == null);
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      name: map['name'] ?? '',
      descripton: map['descripton'],
      id: map['id'],
      studentsId: map['studentsId'] == null
          ? null
          : List<String>.from(map['studentsId']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Course(name: $name, descripton: $descripton, id: $id, studentsId: $studentsId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.name == name &&
        other.descripton == descripton &&
        other.id == id &&
        listEquals(other.studentsId, studentsId);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        descripton.hashCode ^
        id.hashCode ^
        studentsId.hashCode;
  }
}
