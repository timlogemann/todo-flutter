import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todone/models/task.dart';

class DetailRoute extends StatelessWidget {
  DetailRoute({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    final Task task = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Details of the task (with future editing)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                color: Theme.of(context).backgroundColor,
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: 'taskHero' + task.id.toString(),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Todo:' + task.todo),
                            Text('Project:' + task.project),
                            Text('Due on:' +
                                new DateFormat('dd-MM-yyyy')
                                    .format(task.dueDate)),
                            Text('Notes:' + task.note),
                          ]),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
