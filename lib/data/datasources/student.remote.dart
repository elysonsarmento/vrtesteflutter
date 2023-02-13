import 'package:dio/dio.dart';
import 'package:vrteste/domain/domain.dart';

abstract class StudentRemoteDataSource {
  Future<List<Student>> getAllStudent();
  Future<Student> getStudent(String id);
  Future<void> deleteStudent(String id);
  Future<Student> addStudent(Student student);
  Future<Student> updateStudent(Student student);
}

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final Dio dio;

  StudentRemoteDataSourceImpl(this.dio);

  @override
  Future<Student> addStudent(Student student) async {
    final result = await dio.post('/students/create', data: student.toMap());
    return Student.fromMap(result.data);
  }

  @override
  Future<void> deleteStudent(String id) async {
    await dio.delete('/students/delete/$id');
  }

  @override
  Future<List<Student>> getAllStudent() async {
    final result = await dio.get('/students/list').then(
        (value) => value.data.map<Student>((e) => Student.fromMap(e)).toList());
    return result;
  }

  @override
  Future<Student> getStudent(String id) async {
    return await dio
        .get('/students/$id')
        .then((value) => Student.fromMap(value.data));
  }

  @override
  Future<Student> updateStudent(Student student) async {
    return await dio
        .patch('/students/edit/${student.id}', data: student.toMap())
        .then((value) => Student.fromMap(value.data));
  }
}
