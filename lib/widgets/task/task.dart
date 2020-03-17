import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  Task({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).bottomAppBarColor,
        child: Row(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Dit is een todo',
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
                  '3 april 2020',
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
                  'project',
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
                  'Notitie met uitleg',
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
