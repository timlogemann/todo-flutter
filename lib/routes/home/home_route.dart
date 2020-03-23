import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todone/blocs/task/task_bloc.dart';
import 'package:todone/blocs/task/index.dart';
import 'package:todone/models/index.dart' as Model;
import 'package:todone/widgets/index.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TaskBloc _taskBloc;

  _HomePageState();

  @override
  void initState() {
    _taskBloc = BlocProvider.of<TaskBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                color: Theme.of(context).backgroundColor,
                child: TaskList(bloc: _taskBloc),
              ),
              flex: 3,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                color: Theme.of(context).textTheme.body1.color,
                icon: Icon(Icons.list),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.search),
                color: Theme.of(context).textTheme.body1.color,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add task'),
        icon: Icon(
          Icons.edit,
          size: 16,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        tooltip: 'Increment',
        elevation: 2.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget ListView(BuildContext context) {}

  _dismissableCompleted() {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.only(left: 20),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.done,
              color: Colors.white,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  _dismissableDeleted() {
    return Container(
      color: Colors.red,
      padding: EdgeInsets.only(right: 20),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  void dispose() {
    _taskBloc.close();

    super.dispose();
  }
}
