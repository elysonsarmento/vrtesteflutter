import 'package:vrteste/data/data.dart';
import 'package:vrteste/domain/domain.dart';

class CourseRepository extends ICourseRepository {
  final CourseRemoteDataSource remoteDataSource;

  CourseRepository(this.remoteDataSource);

  @override
  Future<List<Course>> getCourses() async {
    return await remoteDataSource.getCourses();
  }

  @override
  Future<Course> addCourse(Course course) async {
    return await remoteDataSource.addCourse(course);
  }

  @override
  Future<void> deleteCourse(String id) async {
    return await remoteDataSource.deleteCourse(id);
  }

  @override
  Future<Course> getCourse(String id) async {
    return await remoteDataSource.getCourse(id);
  }

  @override
  Future<Course> updateCourse(Course course) async {
    return await remoteDataSource.updateCourse(course);
  }
}
