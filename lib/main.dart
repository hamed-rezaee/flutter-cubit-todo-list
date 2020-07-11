import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'package:flutter_cubit_todo/cubit/todo_cubit.dart';
import 'package:flutter_cubit_todo/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cubit',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CubitProvider(
        create: (context) => TodoCubit(),
        child: HomePage(title: 'Home Page'),
      ),
    );
  }
}
