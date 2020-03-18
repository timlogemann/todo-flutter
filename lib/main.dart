import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todone/blocs/task/task_bloc.dart';
import 'package:todone/blocs/task/task_index.dart';
import 'package:todone/routes/index.dart';

void main() => runApp(BlocProvider<TaskBloc>(
      create: (context) => TaskBloc(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 106, 150, 201),
        primaryColorDark: Color.fromARGB(255, 106, 150, 201),
        primaryColorLight: Color.fromARGB(255, 106, 150, 201),
        backgroundColor: Color.fromARGB(255, 19, 22, 25),
        cardColor: Color.fromARGB(255, 54, 63, 71),
        accentColor: Color.fromARGB(255, 54, 63, 71),
        bottomAppBarColor: Color.fromARGB(255, 26, 30, 34),
      ),
      home: HomePage(title: 'Dashboard'),
      routes: <String, WidgetBuilder>{
        '/create': (BuildContext context) => FormRoute(title: 'Create Task'),
      },
    );
  }
}
