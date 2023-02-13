import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vrteste/domain/domain.dart';

class StudentRepositoryMock extends IStudentRepository with Mock {}

class MockStudent extends Mock implements Student {}

void main() {
  final repository = StudentRepositoryMock();
  final student = StudentUsecase(repository);

  setUp(() {
    registerFallbackValue(MockStudent());
  });

  test('should return empty when the call getStudents', () async {
    when(() => repository.getStudents()).thenAnswer((_) async => []);

    final result = await student.getStudents();

    expect(result, []);
    verify(() => repository.getStudents()).called(1);
  });

  test('should return list of student when the call getStudents', () async {
    when(() => repository.getStudents())
        .thenAnswer((_) async => [Student(), Student()]);

    final result = await student.getStudents();

    expect(result.isNotEmpty, true);
    verify(() => repository.getStudents()).called(1);
  });

  test('should return error when the call task getStudents', () {
    when(() => repository.getStudents()).thenThrow(Exception());

    final result = student.getStudents();
    expect(result, throwsA(isA<Exception>()));
    verify(() => repository.getStudents()).called(1);
  });

  test('hould return student when the call getStudent', () async {
    when(() => repository.getStudent(any())).thenAnswer((_) async => Student());

    final result = await student.getStudent('1');

    expect(result, isA<Student>());
    verify(() => repository.getStudent(any())).called(1);
  });

  test('should return error when the call task getStudent', () {
    when(() => repository.getStudent(any())).thenThrow(Exception());

    final result = student.getStudent('1');
    expect(result, throwsA(isA<Exception>()));
    verify(() => repository.getStudent(any())).called(1);
  });

  test('hould return student when the call addStudent', () async {
    final studentTest = MockStudent();
    when(() => repository.addStudent(any()))
        .thenAnswer((_) async => studentTest);

    final result = await student.createStudent(studentTest);

    expect(result, isA<Student>());
    verify(() => repository.addStudent(any())).called(1);
  });

  test('should return error when the call task addStudent', () {
    final studentTest = MockStudent();
    when(() => repository.addStudent(any())).thenThrow(Exception());

    final result = student.createStudent(studentTest);
    expect(result, throwsA(isA<Exception>()));
    verify(() => repository.addStudent(any())).called(1);
  });

  test('hould return student when the call updateStudent', () async {
    final studentTest = MockStudent();
    when(() => repository.updateStudent(any()))
        .thenAnswer((_) async => studentTest);

    final result = await student.updateStudent(studentTest);

    expect(result, isA<Student>());
    verify(() => repository.updateStudent(any())).called(1);
  });

  test('should return error when the call task updateStudent', () {
    final studentTest = MockStudent();
    when(() => repository.updateStudent(any())).thenThrow(Exception());

    final result = student.updateStudent(studentTest);
    expect(result, throwsA(isA<Exception>()));
    verify(() => repository.updateStudent(any())).called(1);
  });

  test('hould return void when the call deleteStudent', () async {
    final studentTest = MockStudent();
    when(() => repository.deleteStudent(any())).thenAnswer((_) async => null);

    final result = await student.deleteStudent('1');

    expect(
      () => result,
      isA<void>(),
    );
    verify(() => repository.deleteStudent(any())).called(1);
  });

  test('should return error when the call task deleteStudent', () {
    final studentTest = MockStudent();
    when(() => repository.deleteStudent(any())).thenThrow(Exception());

    final result = student.deleteStudent('1');
    expect(result, throwsA(isA<Exception>()));
    verify(() => repository.deleteStudent(any())).called(1);
  });
}
