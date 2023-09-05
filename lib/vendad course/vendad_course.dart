import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

const names = ["Abrar", "Ali", "Hammad"];

extension RandomElement<T> on Iterable<T> {
  T getRandomIndex() => elementAt(Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomName() => emit(names.getRandomIndex());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final NamesCubit cubit;
  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  void initState() {
    super.initState();
    cubit = NamesCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Practive'),
      ),
      body: StreamBuilder<String?>(
        stream: cubit.stream,
        builder: (_, result) {
          if (result.data == null) {
            return TextButton(
                onPressed: () => cubit.pickRandomName(),
                child: Text('PICK RANDOM NAME'));
          } else {
            return Column(
              children: [
                Text(result.data!),
                TextButton(
                    onPressed: () => cubit.pickRandomName(),
                    child: Text('PICK RANDOM NAME')),
              ],
            );
          }
        },
      ),
    );
  }
}
