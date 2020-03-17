import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todone/models/index.dart' as Model;

class Task extends StatelessWidget {
  final GestureTapCallback onPressed;

  final Model.Task task;

  Task({@required this.onPressed, this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).bottomAppBarColor,
        child: Row(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: Text(
                  task.todo,
                  style: TextStyle(color: Colors.white),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                margin: EdgeInsets.only(left: 5),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                child: Text(
                  new DateFormat('dd-MM-yyyy').format(task.dueDate),
                  style: TextStyle(color: Colors.white),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                child: Text(
                  task.project,
                  style: TextStyle(color: Colors.white),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                child: Text(
                  task.note,
                  style: TextStyle(color: Colors.white),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                margin: EdgeInsets.only(right: 5),
              )
            ],
          ),
        ]));
  }
}
