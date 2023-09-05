import 'package:bloc_practice/features/home/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'vendad course/vendad_course.dart';

void main() {
  runApp(const MyApp());
}

// @immutable
// abstract class LoadAction {
//   const LoadAction();
//   void addNumber() {}
// }

// @immutable
// class LoadPersonsAction extends LoadAction {
//   final PersonUrls url;

//   LoadPersonsAction({required this.url}) : super();
// }

// @immutable
// class Person {
//   final String name;
//   final String age;
//   const Person({required this.age, required this.name});
//   Person.formJson(Map<String, dynamic> json)
//       : name = json['name'],
//         age = json['age'];
// }

// enum PersonUrls { person1, person2 }

// extension UrlString on PersonUrls {
//   String get urlString {
//     switch (this) {
//       case PersonUrls.person1:
//         return 'http://127.0.0.1:5500/api/persons.json';
//       case PersonUrls.person2:
//         return 'http://127.0.0.1:5500/api/persons2.json';
//     }
//   }
// }

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
      home:  MainPage(),
    );
  }
}
