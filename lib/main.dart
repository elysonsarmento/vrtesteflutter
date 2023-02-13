import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrteste/domain/domain.dart';
import 'package:vrteste/presentation/home/home.view.dart';
import 'package:vrteste/presentation/item_create/cubit/create_cubit.dart';
import 'package:vrteste/presentation/item_create/item.create.dart';
import 'package:vrteste/presentation/list_itens/cubit/list_itens_cubit.dart';
import 'package:vrteste/presentation/list_itens/itens.view.dart';
import 'package:vrteste/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vrteste/utils/enum/itens.type.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'home': (context) => const HomeView(),
        ItensView.ROUTER: (context) {
          final type = (ModalRoute.of(context)!.settings.arguments
              as Map)['type'] as ItensType;

          return BlocProvider(
            create: (context) {
              final cubit = ListItensCubit(
                studentUsecase: context.read<StudentUsecase>(),
                courseUsecase: context.read<CourseUsecase>(),
              );
              if (type == ItensType.students) cubit.getStudents();
              if (type == ItensType.courses) cubit.getCourses();
              return cubit;
            },
            child: ItensView(
              type: type,
            ),
          );
        },
        CreateView.ROUTER: (context) {
          final type = (ModalRoute.of(context)!.settings.arguments
              as Map)['type'] as ItensType;
          final id = (ModalRoute.of(context)!.settings.arguments as Map)['id']
              as String?;
          return BlocProvider(
            create: (context) {
              final cubit = CreateCubit(context.read<StudentUsecase>(),
                  context.read<CourseUsecase>());

              cubit.initialState(type, id);

              return cubit;
            },
            child: CreateView(
              type: type,
            ),
          );
        },
      },
      home: const HomeView(),
    );
  }
}
