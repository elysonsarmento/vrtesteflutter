import 'package:flutter/foundation.dart';

class Student {
  final String? id;
  final String? name;
  final List<String>? coursesId;
  const Student({
    this.id,
    this.name,
    this.coursesId,
  });

  @override
  String toString() => 'Student(id: $id, name: $name, coursesId: $coursesId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.id == id &&
        other.name == name &&
        listEquals(other.coursesId, coursesId);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ coursesId.hashCode;

  Student copyWith({
    String? id,
    String? name,
    List<String>? coursesId,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      coursesId: coursesId ?? this.coursesId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'coursesId': coursesId,
    }..removeWhere((key, value) => value == null);
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      coursesId:
          map['coursesId'] != null ? List<String>.from(map['coursesId']) : null,
    );
  }
}
