import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vrteste/domain/domain.dart';

class CourseRepositoryMock extends ICourseRepository with Mock {}

class MockCourse extends Mock implements Course {}

void main() {
  final repository = CourseRepositoryMock();
  final course = CourseUsecase(repository);

  setUp(() {
    registerFallbackValue(MockCourse());
  });

  test('should return empty when the call getCourses', () async {
    when(() => repository.getCourses()).thenAnswer((_) async => []);

    final result = await course.getCourses();

    expect(result, []);
    verify(() => repository.getCourses()).called(1);
  });

  test('should return list of course when the call getCourses', () async {
    when(() => repository.getCourses())
        .thenAnswer((_) async => [MockCourse(), MockCourse()]);

    final result = await course.getCourses();

    expect(result.isNotEmpty, true);
    verify(() => repository.getCourses()).called(1);
  });

  test('should return error when the call task getCourses', () {
    when(() => repository.getCourses()).thenThrow(Exception());

    final result = course.getCourses();
    expect(result, throwsA(isA<Exception>()));
    verify(() => repository.getCourses()).called(1);
  });

  test('should return course when the call getCourse', () async {
    when(() => repository.getCourse(any()))
        .thenAnswer((_) async => MockCourse());

    final result = await course.getCourse('1');

    expect(result, isA<Course>());
    verify(() => repository.getCourse(any())).called(1);
  });

  test('should return error when the call task getCourse', () {
    when(() => repository.getCourse(any())).thenThrow(Exception());

    final result = course.getCourse('1');
    expect(result, throwsA(isA<Exception>()));
    verify(() => repository.getCourse(any())).called(1);
  });

  test('should return course when the call createCourse', () async {
    when(() => repository.addCourse(any()))
        .thenAnswer((_) async => MockCourse());

    final result = await course.createCourse(MockCourse());

    expect(result, isA<Course>());
    verify(() => repository.addCourse(any())).called(1);
  });

  test('should return error when the call task createCourse', () {
    when(() => repository.addCourse(any())).thenThrow(Exception());

    final result = course.createCourse(MockCourse());
    expect(result, throwsA(isA<Exception>()));
    verify(() => repository.addCourse(any())).called(1);
  });

  test('should return course when the call updateCourse', () async {
    when(() => repository.updateCourse(any()))
        .thenAnswer((_) async => MockCourse());

    final result = await course.updateCourse(MockCourse());

    expect(result, isA<Course>());
    verify(() => repository.updateCourse(any())).called(1);
  });

  test('should return error when the call task updateCourse', () {
    when(() => repository.updateCourse(any())).thenThrow(Exception());

    final result = course.updateCourse(MockCourse());
    expect(result, throwsA(isA<Exception>()));
    verify(() => repository.updateCourse(any())).called(1);
  });

  test('should return void when the call deleteCourse', () async {
    when(() => repository.deleteCourse(any())).thenAnswer((_) async => null);

    final result = await course.deleteCourse('1');

    expect(
      () => result,
      isA<void>(),
    );
    verify(() => repository.deleteCourse(any())).called(1);
  });

  test('should return error when the call task deleteCourse', () {
    when(() => repository.deleteCourse(any())).thenThrow(Exception());

    final result = course.deleteCourse('1');
    expect(result, throwsA(isA<Exception>()));
    verify(() => repository.deleteCourse(any())).called(1);
  });
}
