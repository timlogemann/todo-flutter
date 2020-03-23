import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todone/routes/index.dart';
import 'package:todone/blocs/index.dart';
import 'styles/colors.dart';

void main() => runApp(BlocProvider<TaskBloc>(
      create: (context) => TaskBloc(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = Delegate();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: ToDoneColors.brightBlue,
          primaryColorDark: ToDoneColors.brightBlue,
          primaryColorLight: ToDoneColors.brightBlue,
          splashColor: ToDoneColors.almostWhite,
          backgroundColor: ToDoneColors.almostWhite,
          cardTheme: CardTheme(
            color: Colors.white,
            elevation: 2.0,
          ),
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: ToDoneColors.darkGrey),
            actionsIconTheme: IconThemeData(color: ToDoneColors.darkGrey),
          ),
          accentColor: ToDoneColors.blueishGrey,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.white,
            elevation: 6.0,
          ),
          primaryTextTheme: TextTheme(
            headline: TextStyle(color: ToDoneColors.darkGrey),
            body1: TextStyle(color: ToDoneColors.darkGrey),
            title: TextStyle(color: ToDoneColors.darkGrey),
          )),
      darkTheme: ThemeData(
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: ToDoneColors.whiteish),
            actionsIconTheme: IconThemeData(color: ToDoneColors.whiteish),
          ),
          primaryIconTheme: IconThemeData(
            color: ToDoneColors.whiteish,
            opacity: 0.8,
          ),
          brightness: Brightness.dark,
          primaryColor: ToDoneColors.fadedBlue,
          primaryColorDark: ToDoneColors.fadedBlue,
          primaryColorLight: ToDoneColors.fadedBlue,
          splashColor: ToDoneColors.darkGrey,
          backgroundColor: ToDoneColors.darkGrey,
          cardTheme: CardTheme(
            color: ToDoneColors.blueishGrey,
            elevation: 2.0,
          ),
          accentColor: ToDoneColors.blueishGrey,
          bottomAppBarTheme: BottomAppBarTheme(
              color: Color.fromARGB(255, 26, 30, 34), elevation: 6.0),
          primaryTextTheme: TextTheme(
            headline: TextStyle(color: ToDoneColors.whiteish),
            body1: TextStyle(color: ToDoneColors.whiteish),
            title: TextStyle(color: ToDoneColors.whiteish),
          )),
      home: HomePage(title: 'Dashboard'),
      routes: <String, WidgetBuilder>{
        '/create': (BuildContext context) => FormRoute(title: 'Create Task'),
        '/detail': (BuildContext context) => DetailRoute(),
      },
    );
  }
}
