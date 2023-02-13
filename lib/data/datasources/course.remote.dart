import 'package:dio/dio.dart';
import 'package:vrteste/domain/domain.dart';

abstract class CourseRemoteDataSource {
  Future<List<Course>> getCourses();
  Future<Course> getCourse(String id);
  Future<Course> addCourse(Course course);
  Future<Course> updateCourse(Course course);
  Future<void> deleteCourse(String id);
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final Dio dio;

  CourseRemoteDataSourceImpl(this.dio);

  @override
  Future<Course> addCourse(Course course) async {
    final result = await dio.post('/courses/create', data: course.toMap());
    return Course.fromMap(result.data);
  }

  @override
  Future<void> deleteCourse(String id) async {
    await dio.delete('/courses/delete/$id');
  }

  @override
  Future<List<Course>> getCourses() async {
    return await dio.get('/courses/list').then(
        (value) => value.data.map<Course>((e) => Course.fromMap(e)).toList());
  }

  @override
  Future<Course> getCourse(String id) async {
    return await dio
        .get('/courses/$id')
        .then((value) => Course.fromMap(value.data));
  }

  @override
  Future<Course> updateCourse(Course course) async {
    return await dio
        .patch('/courses/edit/${course.id}', data: course.toMap())
        .then((value) => Course.fromMap(value.data));
  }
}
