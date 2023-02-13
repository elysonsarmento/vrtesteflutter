import 'package:vrteste/domain/entities/course.entity.dart';

abstract class ICourseRepository {
  Future<List<Course>> getCourses();
  Future<Course> getCourse(String id);
  Future<Course> addCourse(Course course);
  Future<Course> updateCourse(Course course);
  Future<void> deleteCourse(String id);
}
