import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todone/blocs/task/task_bloc.dart';
import 'package:todone/blocs/task/task_index.dart';
import 'package:todone/routes/index.dart';
import 'styles/colors.dart';

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
          brightness: Brightness.light,
          primaryColor: Color.fromARGB(255, 75, 147, 255),
          primaryColorDark: Color.fromARGB(255, 106, 150, 201),
          primaryColorLight: Color.fromARGB(255, 106, 150, 201),
          splashColor: Color.fromARGB(255, 245, 245, 245),
          backgroundColor: Color.fromARGB(255, 245, 245, 245),
          cardTheme: CardTheme(
            color: Color.fromARGB(255, 255, 255, 255),
            elevation: 2.0,
          ),
          accentColor: Color.fromARGB(255, 54, 63, 71),
          bottomAppBarTheme: BottomAppBarTheme(
              color: Color.fromARGB(255, 255, 255, 255), elevation: 6.0),
          primaryTextTheme: TextTheme(
            headline: TextStyle(color: ToDoneColors.darkGrey),
            body1: TextStyle(color: ToDoneColors.darkGrey),
            title: TextStyle(color: ToDoneColors.darkGrey),
          )),
      darkTheme: ThemeData(
          primaryIconTheme: IconThemeData(
            color: Color.fromARGB(255, 230, 225, 222),
            opacity: 0.8,
          ),
          brightness: Brightness.dark,
          primaryColor: Color.fromARGB(255, 106, 150, 201),
          primaryColorDark: Color.fromARGB(255, 106, 150, 201),
          primaryColorLight: Color.fromARGB(255, 106, 150, 201),
          splashColor: ToDoneColors.darkGrey,
          backgroundColor: ToDoneColors.darkGrey,
          cardTheme: CardTheme(
            color: Color.fromARGB(255, 54, 63, 71),
            elevation: 2.0,
          ),
          accentColor: Color.fromARGB(255, 54, 63, 71),
          bottomAppBarTheme: BottomAppBarTheme(
              color: Color.fromARGB(255, 26, 30, 34), elevation: 6.0),
          primaryTextTheme: TextTheme(
            headline: TextStyle(color: Color.fromARGB(255, 230, 225, 222)),
            body1: TextStyle(color: Color.fromARGB(255, 230, 225, 222)),
            title: TextStyle(color: Color.fromARGB(255, 230, 225, 222)),
          )),
      home: HomePage(title: 'Dashboard'),
      routes: <String, WidgetBuilder>{
        '/create': (BuildContext context) => FormRoute(title: 'Create Task'),
        '/detail': (BuildContext context) => DetailRoute(),
      },
    );
  }
}
