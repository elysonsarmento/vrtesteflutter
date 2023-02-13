import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vrteste/domain/domain.dart';

part 'list_itens_state.dart';

class ListItensCubit extends Cubit<ListItensState> {
  final StudentUsecase? studentUsecase;
  final CourseUsecase? courseUsecase;
  ListItensCubit({this.studentUsecase, this.courseUsecase})
      : super(ListItensInitial());

  // STUDENT
  Future<void> getStudents() async {
    emit(ListItensLoading());
    try {
      final result = await studentUsecase?.getStudents();
      emit(ListItensLoaded(students: result));
    } catch (e) {
      emit(ListItensError(e.toString()));
    }
  }

  Future<void> deleteStudent(String id) async {
    emit(ListItensLoading());
    try {
      await studentUsecase?.deleteStudent(id);
      emit(const ListItensLoadedDelete());
      getStudents();
    } catch (e) {
      emit(ListItensError(e.toString()));
    }
  }

  Future<void> getCourses() async {
    emit(ListItensInitial());
    try {
      final result = await courseUsecase?.getCourses();
      emit(ListItensLoaded(course: result));
    } catch (e) {
      emit(ListItensError(e.toString()));
    }
  }

  Future<void> deleteCourse(String id) async {
    emit(ListItensLoading());
    try {
      await courseUsecase?.deleteCourse(id);
      emit(const ListItensLoadedDelete());
      getCourses();
    } catch (e) {
      emit(ListItensError(e.toString()));
    }
  }
}
