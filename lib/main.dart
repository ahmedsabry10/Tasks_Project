import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tests/home_layout.dart';
import 'package:tests/shared/shared.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Bloc.observer = MyBlocObserver();
    return MaterialApp(
      title: 'Flutter Demo',

      home:Test(),
      debugShowCheckedModeBanner: false,
    );
  }
}

