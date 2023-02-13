part of 'create_cubit.dart';

abstract class CreateState extends Equatable {
  const CreateState();

  @override
  List<Object> get props => [];
}

class CreateLoading extends CreateState {}

class CreateLoaded extends CreateState {}

class CreateLoadedCourse extends CreateState {
  Course course;
  CreateLoadedCourse({
    required this.course,
  });
}

class CreateLoadedStudent extends CreateState {
  Student? student;
  List<Course>? listCourse;
  CreateLoadedStudent({
    required this.student,
    this.listCourse,
  });

  @override
  List<Object> get props => [];

  CreateLoadedStudent copyWith({
    Student? student,
    List<Course>? listCourse,
  }) {
    return CreateLoadedStudent(
      student: student ?? this.student,
      listCourse: listCourse ?? this.listCourse,
    );
  }
}

class CreateError extends CreateState {
  final String message;
  const CreateError(this.message);

  @override
  List<Object> get props => [message];
}
