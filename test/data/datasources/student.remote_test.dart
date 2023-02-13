import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vrteste/data/datasources/student.remote.dart';
import 'package:vrteste/domain/domain.dart';

class MockDio extends Mock implements Dio {}

class MockOptions extends Mock implements RequestOptions {}

void main() {
  final dio = MockDio();
  final sut = StudentRemoteDataSourceImpl(dio);

  setUp(() {
    registerFallbackValue(MockOptions());
  });
  test('should return list when the call getall', () async {
    when(() => dio.get('/list')).thenAnswer((_) async => Response(data: [
          {
            'id': "1",
            'name': 'Teste',
          }
        ], requestOptions: MockOptions()));

    final result = await sut.getAllStudent();

    expect(result.isNotEmpty, true);
    verify(() => dio.get('/list')).called(1);
  });

  test('should return error when the call getall', () {
    when(() => dio.get('/list')).thenThrow(Exception());

    final result = sut.getAllStudent();

    expect(result, throwsA(isA<Exception>()));
    verify(() => dio.get('/list')).called(1);
  });

  test('should return student when the call getbyid', () async {
    when(() => dio.get('/1')).thenAnswer((_) async => Response(data: {
          'id': "1",
          'name': 'Teste',
        }, requestOptions: MockOptions()));

    final result = await sut.getStudent('1');

    expect(result.id, '1');
    verify(() => dio.get('/1')).called(1);
  });

  test('should return error when the call getbyid', () {
    when(() => dio.get('/1')).thenThrow(Exception());

    final result = sut.getStudent('1');

    expect(result, throwsA(isA<Exception>()));
    verify(() => dio.get('/1')).called(1);
  });

  test('should return student when the call add', () async {
    when(() => dio.post('/create', data: {
          'id': "1",
          'name': 'Teste',
        })).thenAnswer((_) async => Response(data: {
          'id': "1",
          'name': 'Teste',
        }, requestOptions: MockOptions()));

    final result = await sut.addStudent(Student(id: '1', name: 'Teste'));

    expect(result.id, '1');
    verify(() => dio.post('/create', data: {
          'id': "1",
          'name': 'Teste',
        })).called(1);
  });

  test('should return error when the call add', () {
    when(() => dio.post('/create', data: {
          'id': "1",
          'name': 'Teste',
        })).thenThrow(Exception());

    final result = sut.addStudent(Student(id: '1', name: 'Teste'));

    expect(result, throwsA(isA<Exception>()));
    verify(() => dio.post('/create', data: {
          'id': "1",
          'name': 'Teste',
        })).called(1);
  });

  test('should return student when the call update', () async {
    when(() => dio.patch('/edit/1', data: {
          'id': "1",
          'name': 'Teste',
        })).thenAnswer((_) async => Response(data: {
          'id': "1",
          'name': 'Teste',
        }, requestOptions: MockOptions()));

    final result = await sut.updateStudent(Student(id: '1', name: 'Teste'));

    expect(result.id, '1');
    verify(() => dio.patch('/edit/1', data: {
          'id': "1",
          'name': 'Teste',
        })).called(1);
  });

  test('should return error when the call update', () {
    when(() => dio.patch('/edit/1', data: {
          'id': "1",
          'name': 'Teste',
        })).thenThrow(Exception());

    final result = sut.updateStudent(Student(id: '1', name: 'Teste'));

    expect(result, throwsA(isA<Exception>()));
    verify(() => dio.patch('/edit/1', data: {
          'id': "1",
          'name': 'Teste',
        })).called(1);
  });

  test('should return student when the call delete', () async {
    when(() => dio.delete('/delete/1')).thenAnswer((_) async => Response(data: {
          'id': "1",
          'name': 'Teste',
        }, requestOptions: MockOptions()));

    final result = await sut.deleteStudent('1');

    expect(
      () => result,
      isA<void>(),
    );
    verify(() => dio.delete('/delete/1')).called(1);
  });

  test('should return error when the call delete', () {
    when(() => dio.delete('/delete/1')).thenThrow(Exception());

    final result = sut.deleteStudent('1');

    expect(result, throwsA(isA<Exception>()));
    verify(() => dio.delete('/delete/1')).called(1);
  });
}
