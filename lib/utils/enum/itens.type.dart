enum ItensType {
  students,
  courses,
}

extension ItensTypeExtension on ItensType {
  String get name {
    switch (this) {
      case ItensType.students:
        return 'Estudantes';
      case ItensType.courses:
        return 'Cursos';
    }
  }
}
