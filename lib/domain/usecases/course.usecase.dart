import 'package:vrteste/domain/domain.dart';

class CourseUsecase {
  final ICourseRepository _courseRepository;

  CourseUsecase(this._courseRepository);

  Future<List<Course>> getCourses() async {
    return await _courseRepository.getCourses();
  }

  Future<Course> getCourse(String id) async {
    return await _courseRepository.getCourse(id);
  }

  Future<Course> createCourse(Course course) async {
    return await _courseRepository.addCourse(course);
  }

  Future<Course> updateCourse(Course course) async {
    return await _courseRepository.updateCourse(course);
  }

  Future<void> deleteCourse(String id) async {
    return await _courseRepository.deleteCourse(id);
  }
}
