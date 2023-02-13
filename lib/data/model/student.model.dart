import 'package:vrteste/domain/entities/student.entity.dart';

class StudentModel extends Student {
  String? id;
  String? name;
  List<String>? coursesId;

  StudentModel({super.id, super.name, super.coursesId});
}
