import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Bloc Practice'),
    );
  }
}

const List names = ['abrar', 'ali', 'imtiaz'];
Random rand = Random();

extension RandomElement<T> on Iterable<T> {
  T getRandomElements() => elementAt(rand.nextInt(length));
}

class NameCubit extends Cubit<String?> {
  NameCubit() : super(null);
  void pickRandomName() => emit(names.getRandomElements());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final NameCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = NameCubit();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<String?>(
        stream: cubit.stream,
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${snapshot.data}'),
                TextButton(onPressed: (){
                  cubit.pickRandomName();
                }, child: const Text('Pick random number'))
              ],
            ),
          );
        }
      ),
    );
  }
}
