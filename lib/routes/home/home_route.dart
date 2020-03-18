import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todone/blocs/task/task_bloc.dart';
import 'package:todone/blocs/task/task_index.dart';
import 'package:todone/widgets/index.dart';
import 'package:todone/routes/index.dart';

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
                padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                color: Theme.of(context).backgroundColor,
                child: BlocBuilder<TaskBloc, TaskState>(
                    builder: (BuildContext context, TaskState state) {
                  if (state is TasksLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                    itemBuilder: (task, index) =>
                        Task(onPressed: null, task: state.tasks[index]),
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: state.tasks.length,
                  );
                }),
              ),
              flex: 3,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).bottomAppBarColor,
        elevation: 5,
        child: Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.list),
                color: Theme.of(context).accentColor,
                onPressed: () {},
              ),
              // IconButton(
              //   iconSize: 30.0,
              //   padding: EdgeInsets.only(right: 28.0),
              //   icon: Icon(Icons.search),
              //   onPressed: () {},
              // ),
              // IconButton(
              //   iconSize: 30.0,
              //   padding:  EdgeInsets.only(left: 28.0),
              //   icon: Icon(Icons.notifications),
              //   onPressed: () {},
              // ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.search),
                color: Theme.of(context).accentColor,
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

  @override
  void dispose() {
    _taskBloc.close();

    super.dispose();
  }
}
