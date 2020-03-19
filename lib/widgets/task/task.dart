import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todone/models/index.dart' as Model;

class Task extends StatefulWidget {
  final GestureTapCallback onPressed;

  final Model.Task task;

  Task({@required this.onPressed, this.task});

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool _isOpen = false;

  _TaskState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Hero(
        transitionOnUserGestures: true,
        tag: 'taskHero' + widget.task.id.toString(),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      widget.task.todo,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    margin: EdgeInsets.only(left: 5),
                  ),
                  Container(
                    child: Text(
                      new DateFormat('dd-MM-yyyy').format(widget.task.dueDate),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  ),
                  Container(
                    child: Text(
                      widget.task.project,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  _renderToggle(),
                ],
              ),
              Row(children: <Widget>[
                _renderTaskDescription(),
              ]),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _renderToggle() {
    if (widget.task.note == '') {
      return Container(width: 35);
    }

    return Container(
      width: 35,
      child: IconButton(
        icon: Icon(_isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
        onPressed: () {
          setState(() {
            _isOpen = !_isOpen;
          });
        },
      ),
    );
  }

  Widget _renderTaskDescription() {
    if (_isOpen) {
      return Container(
        child: Text(
          widget.task.note,
        ),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
        margin: EdgeInsets.only(right: 5),
      );
    }

    return Container();
  }
}
