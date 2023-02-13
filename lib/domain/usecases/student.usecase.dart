import 'package:vrteste/domain/entities/student.entity.dart';
import 'package:vrteste/domain/repository/student.repository.dart';

class StudentUsecase {
  final IStudentRepository repository;

  StudentUsecase(this.repository);

  Future<List<Student>> getStudents() async {
    try {
      return await repository.getStudents();
    } catch (e) {
      throw Exception();
    }
  }

  Future<Student> getStudent(String id) async {
    try {
      return await repository.getStudent(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<Student> createStudent(Student student) async {
    try {
      return await repository.addStudent(student);
    } catch (e) {
      rethrow;
    }
  }

  Future<Student> updateStudent(Student student) async {
    return await repository.updateStudent(student);
  }

  Future<void> deleteStudent(String id) async {
    return await repository.deleteStudent(id);
  }
}
