import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vrteste/domain/domain.dart';
import 'package:vrteste/utils/enum/itens.type.dart';

part 'create_state.dart';

class CreateCubit extends Cubit<CreateState> {
  final StudentUsecase studentUsecase;
  final CourseUsecase courseUsecase;
  CreateCubit(this.studentUsecase, this.courseUsecase)
      : super(CreateLoadedStudent(student: const Student()));

  Future<void> createStudent(Student student) async {
    emit(CreateLoading());
    try {
      final result = await studentUsecase.createStudent(student);
      emit(CreateLoadedStudent(student: result));
      emit(CreateLoaded());
    } catch (e) {
      emit(CreateError(e.toString()));
    }
  }

  Future<void> updateStudent(Student student) async {
    emit(CreateLoading());
    try {
      final result = await studentUsecase.updateStudent(student);
      emit(CreateLoadedStudent(student: result));
    } catch (e) {
      emit(CreateError(e.toString()));
    }
  }

  Future<void> getStudent(String id) async {
    emit(CreateLoading());
    try {
      final result = await studentUsecase.getStudent(id);
      final listCourse = await courseUsecase.getCourses();
      emit(CreateLoadedStudent(student: result, listCourse: listCourse));
    } catch (e) {
      emit(CreateError(e.toString()));
    }
  }

  Future<void> createCourse(Course course) async {
    emit(CreateLoading());
    try {
      final result = await courseUsecase.createCourse(course);
      emit(CreateLoadedCourse(course: result));
      emit(CreateLoaded());
    } catch (e) {
      emit(CreateError(e.toString()));
    }
  }

  Future<void> updateCourse(Course course) async {
    emit(CreateLoading());
    try {
      final result = await courseUsecase.updateCourse(course);
      emit(CreateLoadedCourse(course: result));
    } catch (e) {
      emit(CreateError(e.toString()));
    }
  }

  Future<void> getCourse(String id) async {
    emit(CreateLoading());
    try {
      final result = await courseUsecase.getCourse(id);
      emit(CreateLoadedCourse(course: result));
    } catch (e) {
      emit(CreateError(e.toString()));
    }
  }

  Future<void> initialState(ItensType type, String? id) async {
    if (type == ItensType.students) {
      if (id != null) {
        await getStudent(id);
      } else {
        final listCourse = await courseUsecase.getCourses();
        emit(CreateLoadedStudent(listCourse: listCourse, student: Student()));
      }
    } else if (type == ItensType.courses) {
      if (id != null) {
        await getCourse(id);
      } else {
        emit(CreateLoadedCourse(course: Course(name: '')));
      }
    }
  }
}
