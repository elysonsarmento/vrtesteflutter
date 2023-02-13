import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vrteste/data/data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vrteste/data/repository/course.repository.dart';
import 'package:vrteste/domain/domain.dart';

final providers = <SingleChildWidget>[
  // DIO
  Provider<Dio>(
      create: (ref) => Dio(
            BaseOptions(
              baseUrl: dotenv.env['ADRESS']!,
            ),
          )),

  // REMOTE DATA SOURCES
  Provider<StudentRemoteDataSource>(create: (ref) {
    return StudentRemoteDataSourceImpl(ref.read());
  }),
  Provider<CourseRemoteDataSource>(create: (ref) {
    return CourseRemoteDataSourceImpl(ref.read());
  }),

  // REPOSITORIES

  Provider<StudentRepository>(
      create: (ref) => StudentRepository(ref.read<StudentRemoteDataSource>())),

  Provider<CourseRepository>(
      create: (ref) => CourseRepository(ref.read<CourseRemoteDataSource>())),

  // USE CASES
  Provider<StudentUsecase>(
      create: (ref) => StudentUsecase(ref.read<StudentRepository>())),

  Provider<CourseUsecase>(
      create: (ref) => CourseUsecase(ref.read<CourseRepository>())),
];
