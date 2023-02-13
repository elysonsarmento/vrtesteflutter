import 'package:vrteste/data/datasources/datasources.dart';
import 'package:vrteste/domain/domain.dart';

class StudentRepository implements IStudentRepository {
  final StudentRemoteDataSource remoteDataSource;

  StudentRepository(this.remoteDataSource);

  @override
  Future<List<Student>> getStudents() async {
    return await remoteDataSource.getAllStudent();
  }

  @override
  Future<Student> addStudent(Student student) async {
    return await remoteDataSource.addStudent(student);
  }

  @override
  Future<void> deleteStudent(String id) async {
    return await remoteDataSource.deleteStudent(id);
  }

  @override
  Future<Student> getStudent(String id) async {
    return await remoteDataSource.getStudent(id);
  }

  @override
  Future<Student> updateStudent(Student student) async {
    return await remoteDataSource.updateStudent(student);
  }
}
