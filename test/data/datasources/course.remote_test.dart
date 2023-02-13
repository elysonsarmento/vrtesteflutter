import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vrteste/data/data.dart';
import 'package:vrteste/domain/domain.dart';

class MockDio extends Mock implements Dio {}

class MockOptions extends Mock implements RequestOptions {}

void main() {
  final dio = MockDio();
  final options = MockOptions();
  final sut = CourseRemoteDataSourceImpl(dio);

  setUp(() {
    registerFallbackValue(MockOptions());
  });

  test('should return list when the call getall', () {
    when(() => dio.get('/list')).thenAnswer((_) async => Response(data: [
          {
            'id': "1",
            'name': 'Teste',
          }
        ], requestOptions: options));

    final result = sut.getCourses();

    expect(result, isA<Future<List<Course>>>());
    verify(() => dio.get('/list')).called(1);
  });

  test('should return course when the call get', () {
    when(() => dio.get('/1')).thenAnswer((_) async => Response(data: {
          'id': "1",
          'name': 'Teste',
        }, requestOptions: options));

    final result = sut.getCourse('1');

    expect(result, isA<Future<Course>>());
    verify(() => dio.get('/1')).called(1);
  });

  test('should return void when the call delete', () {
    when(() => dio.delete('/delete/1')).thenAnswer((_) async => Response(
        data: null,
        requestOptions: options,
        statusCode: 200,
        statusMessage: 'OK'));

    final result = sut.deleteCourse('1');

    expect(result, isA<Future<void>>());
    verify(() => dio.delete('/delete/1')).called(1);
  });

  test('should return error when the call getall', () {
    when(() => dio.get('/list')).thenThrow(Exception());

    final result = sut.getCourses();

    expect(result, throwsA(isA<Exception>()));
    verify(() => dio.get('/list')).called(1);
  });

  test('should return error when the call get', () {
    when(() => dio.get('/1')).thenThrow(Exception());

    final result = sut.getCourse('1');

    expect(result, throwsA(isA<Exception>()));
    verify(() => dio.get('/1')).called(1);
  });
  test('should return error when the call delete', () {
    when(() => dio.delete('/delete/1')).thenThrow(Exception());

    final result = sut.deleteCourse('1');

    expect(result, throwsA(isA<Exception>()));
    verify(() => dio.delete('/delete/1')).called(1);
  });
}
