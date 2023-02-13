import 'package:flutter/material.dart';
import 'package:vrteste/presentation/item_create/item.create.dart';
import 'package:vrteste/presentation/list_itens/cubit/list_itens_cubit.dart';
import 'package:vrteste/presentation/widgets/widgets.dart';
import 'package:vrteste/utils/enum/itens.type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItensView extends StatelessWidget {
  static const ROUTER = '/itens';

  final ItensType type;
  const ItensView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateView.ROUTER,
              arguments: {"type": type}).then((value) {
            if (type == ItensType.students) {
              context.read<ListItensCubit>().getStudents();
            }
            if (type == ItensType.courses) {
              context.read<ListItensCubit>().getCourses();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Lista de ${type.name}'),
      ),
      body: BlocBuilder<ListItensCubit, ListItensState>(
        buildWhen: (previous, state) {
          if (state is ListItensError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Error ao completar a ação'),
            ));
            return true;
          }
          if (state is ListItensLoadedDelete) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Sucesso ao remover o item'),
            ));
            return true;
          }
          return true;
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ListItensInitial:
            case ListItensLoading:
            case ListItensLoadedDelete:
              return const Center(child: CircularProgressIndicator());
            case ListItensError:
              return Center(
                child: Text((state as ListItensError).message),
              );
            case ListItensLoaded:
              switch (type) {
                case ItensType.students:
                  final students = (state as ListItensLoaded).students;
                  return ListView.builder(
                    itemCount: students?.length,
                    itemBuilder: (context, index) {
                      final item = students?[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            CardItem(
                              title: item?.name ?? '',
                              onTap: () {
                                Navigator.pushNamed(context, CreateView.ROUTER,
                                    arguments: {"type": type, "id": item!.id});
                              },
                              onDelete: () async {
                                await context
                                    .read<ListItensCubit>()
                                    .deleteStudent(item!.id!);
                              },
                            ),
                            const SizedBox(height: 10)
                          ],
                        ),
                      );
                    },
                  );
                case ItensType.courses:
                  final course = (state as ListItensLoaded).course;
                  return ListView.builder(
                    itemCount: course?.length,
                    itemBuilder: (context, index) {
                      final item = course?[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            CardItem(
                              title: item?.name ?? '',
                              onTap: () {
                                Navigator.pushNamed(context, CreateView.ROUTER,
                                    arguments: {
                                      "type": type,
                                      "id": item!.id
                                    }).then((value) => context
                                    .read<ListItensCubit>()
                                    .getCourses());
                              },
                              onDelete: () async {
                                await context
                                    .read<ListItensCubit>()
                                    .deleteCourse(item!.id!);
                              },
                            ),
                            const SizedBox(height: 10)
                          ],
                        ),
                      );
                    },
                  );
              }
            default:
              return const Center(child: Text('Erro desconhecido'));
          }
        },
      ),
    );
  }
}
