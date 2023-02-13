part of 'list_itens_cubit.dart';

abstract class ListItensState extends Equatable {
  const ListItensState();

  @override
  List<Object> get props => [];
}

class ListItensInitial extends ListItensState {}

class ListItensLoading extends ListItensState {}

class ListItensLoaded extends ListItensState {
  final List<Student>? students;
  final List<Course>? course;
  const ListItensLoaded({this.course, this.students});

  @override
  List<Object> get props => [students ?? []];
}

class ListItensLoadedDelete extends ListItensLoaded {
  const ListItensLoadedDelete({List<Student>? students, List<Course>? course})
      : super(students: students, course: course);
  @override
  List<Object> get props => [students ?? []];
}

class ListItensError extends ListItensState {
  final String message;
  const ListItensError(this.message);

  @override
  List<Object> get props => [message];
}
