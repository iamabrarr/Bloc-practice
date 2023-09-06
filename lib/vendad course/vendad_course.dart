import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const Iterable<String> names = ['foo', 'bar'];

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

@immutable
abstract class LoadAction {
  const LoadAction();
}

//ACTIONs ARE INPUT
@immutable
class LoadPersonAction implements LoadAction {
  final PersonUrl url;
  LoadPersonAction({required this.url});
}

//BLOC
class PersonBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};
  PersonBloc() : super(null) {
    //EVENT IS INPUTE AND EMIT IS OUTPUT
    on<LoadPersonAction>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        //WE HAVE CACHE
        final _cachedPersons = _cache[url]!;
        final result =
            FetchResult(isRetrievedFromCache: true, person: _cachedPersons);
        emit(result);
      } else {
        final persons = await getPerson(url.urlString);
        _cache[url] = persons;
        final result =
            FetchResult(isRetrievedFromCache: false, person: persons);
      }
    });
  }
}

@immutable
class FetchResult {
  final Iterable<Person> person;
  final bool isRetrievedFromCache;
  FetchResult({required this.isRetrievedFromCache, required this.person});
  @override
  String toString() {
    return 'Fetch Result (isRetrievedFromCache = $isRetrievedFromCache, persons = $person)';
  }
}

//MODEL
@immutable
class Person {
  final String name;
  final String age;
  // Person({required this.age, required this.name});
  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'];
}

Future<Iterable<Person>> getPerson(String url) async => HttpClient()
    .getUrl(Uri.parse(url))
    .then((value) => value.close())
    .then((resp) => resp.transform(utf8.decoder).join())
    .then((str) => jsonDecode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));

enum PersonUrl { person1, person2 }

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.person1:
        return 'http://127.0.0.1:5500/api/persons.json';
      case PersonUrl.person2:
        return 'http://127.0.0.1:5500/api/persons2.json';
    }
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HELLo'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    final foc = context
                        .read<PersonBloc>()
                        .add(LoadPersonAction(url: PersonUrl.person1));
                  },
                  child: Text('Load json #1')),
              TextButton(onPressed: () {
                final foc = context
                        .read<PersonBloc>()
                        .add(LoadPersonAction(url: PersonUrl.person2));
              }, child: Text('Load json #2')),
            ],
          ),
          BlocBuilder<PersonBloc, FetchResult?>(
            buildWhen: (previousResult, currentResult) {
              return previousResult?.person != currentResult?.person;
            },
            builder: (context, fetchResult) {
              final persons=fetchResult?.person;
              if(persons==null){
                return SizedBox();
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: persons.length,
                  shrinkWrap: true,
                  itemBuilder: (_,i)=>ListTile(title: Text(persons[i]!.name),)),
              );
            },
          ),
        ],
      ),
    );
  }
}
