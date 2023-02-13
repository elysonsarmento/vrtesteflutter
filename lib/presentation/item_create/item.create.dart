import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vrteste/domain/entities/student.entity.dart';
import 'package:vrteste/presentation/item_create/cubit/create_cubit.dart';
import 'package:vrteste/presentation/widgets/card.item.dart';
import 'package:vrteste/utils/enum/itens.type.dart';

class CreateView extends StatefulWidget {
  static const ROUTER = '/create';
  final ItensType type;
  const CreateView({
    super.key,
    required this.type,
  });

  @override
  State<CreateView> createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  bool canSave = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar ${widget.type.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<CreateCubit, CreateState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case CreateLoadedStudent:
                state as CreateLoadedStudent;
                return Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          TextFieldWithTitle(
                            title: 'Nome do aluno',
                            initialValue: state.student?.name,
                            onChanged: (value, isNewValue) {
                              setState(() {
                                canSave = !isNewValue;
                              });
                              state.student =
                                  state.student?.copyWith(name: value);
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            child:
                                Text('Cursos', style: TextStyle(fontSize: 16)),
                          ),
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.listCourse?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final course = state.listCourse?[index];
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CardItem(
                                        icon: state.student?.coursesId
                                                    ?.contains(course!.id!) ==
                                                true
                                            ? Icons.remove
                                            : Icons.add,
                                        title: 'Curso ${course!.name}',
                                        onTap: () {
                                          setState(() {
                                            if (state.student == null ||
                                                state.student!.coursesId ==
                                                    null) {
                                              state.student = state.student!
                                                  .copyWith(
                                                      coursesId: [course.id!]);
                                            } else {
                                              state.student = state.student!
                                                  .copyWith(coursesId: [
                                                ...state.student!.coursesId!,
                                                course.id!
                                              ]);
                                            }
                                            if (state.student != null ||
                                                state.student!.name!
                                                    .isNotEmpty) {
                                              canSave = true;
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    saveButton(context, () async {
                      try {
                        await context
                            .read<CreateCubit>()
                            .createStudent(state.student!);
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Error ao completar a ação'),
                        ));
                      }
                    })
                  ],
                );
              case CreateLoading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case CreateLoadedCourse:
                state as CreateLoadedCourse;
                return Column(
                  children: [
                    Column(
                      children: [
                        TextFieldWithTitle(
                          title: 'Nome do curso',
                          initialValue: state.course.name,
                          onChanged: (value, isNewValue) {
                            setState(() {
                              canSave = !isNewValue;
                            });
                            state.course = state.course.copyWith(name: value);
                          },
                        ),
                        TextFieldWithTitle(
                          title: 'Descrição',
                          initialValue: state.course.name,
                          onChanged: (value, isNewValue) {
                            setState(() {
                              canSave = !isNewValue;
                            });
                            state.course = state.course.copyWith(name: value);
                          },
                        ),
                      ],
                    ),
                    saveButton(context, () async {
                      try {
                        if (state.course.id == null) {
                          await context
                              .read<CreateCubit>()
                              .createCourse(state.course);
                          Navigator.pop(context);
                        } else {
                          await context
                              .read<CreateCubit>()
                              .updateCourse(state.course);
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Error ao completar a ação'),
                        ));
                      }
                    })
                  ],
                );
              case CreateError:
                return Center(
                  child: Text((state as CreateError).message.toString()),
                );
              default:
                return const Center(
                  child: Text('Error'),
                );
            }
          },
        ),
      ),
    );
  }

  ElevatedButton saveButton(BuildContext context, Function onTap) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(canSave ? Colors.blue : Colors.grey),
        ),
        onPressed: () {
          if (canSave) {
            onTap();
          }
        },
        child: const Text('Salvar'));
  }
}

class TextFieldWithTitle extends StatefulWidget {
  final String title;
  final String? initialValue;
  final int? maxline;
  final Function(String value, bool isNewValue)? onChanged;
  TextFieldWithTitle({
    super.key,
    required this.title,
    this.initialValue,
    this.maxline,
    this.onChanged,
  });

  @override
  State<TextFieldWithTitle> createState() => _TextFieldWithTitleState();
}

class _TextFieldWithTitleState extends State<TextFieldWithTitle> {
  var initialValue;
  TextEditingController? controller;

  @override
  void initState() {
    initialValue = widget.initialValue ?? '';
    controller = TextEditingController(text: initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          child: Text(widget.title, style: const TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 5),
        TextField(
            onChanged: (value) {
              widget.onChanged?.call(
                  value,
                  (value == widget.initialValue && value.isNotEmpty) ||
                      !value.isNotEmpty);
              setState(() {
                initialValue = value;
              });
            },
            maxLines: widget.maxline,
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
            )),
      ],
    );
  }
}
