import 'package:vrteste/domain/entities/student.entity.dart';

abstract class IStudentRepository {
  Future<List<Student>> getStudents();
  Future<Student> getStudent(String id);
  Future<Student> addStudent(Student student);
  Future<Student> updateStudent(Student student);
  Future<void> deleteStudent(String id);
}
