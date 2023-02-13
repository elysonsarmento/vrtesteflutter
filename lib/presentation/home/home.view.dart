import 'package:flutter/material.dart';
import 'package:vrteste/presentation/list_itens/itens.view.dart';
import 'package:vrteste/presentation/widgets/widgets.dart';
import 'package:vrteste/utils/enum/itens.type.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CardItem(
                  title: 'Alunos',
                  onTap: () => Navigator.pushNamed(context, ItensView.ROUTER,
                      arguments: {'type': ItensType.students})),
              const SizedBox(height: 10),
              CardItem(
                  title: 'Curso',
                  onTap: () => Navigator.pushNamed(context, ItensView.ROUTER,
                      arguments: {'type': ItensType.courses})),
            ],
          ),
        ),
      ),
    );
  }
}
