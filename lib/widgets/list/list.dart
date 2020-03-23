import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todone/blocs/index.dart';
import 'package:todone/models/index.dart' as Model;
import 'package:todone/widgets/task/task.dart';

class TaskList extends StatelessWidget {
  final TaskBloc bloc;
  final bool filterOnCompletedState;

  TaskList({this.bloc, this.filterOnCompletedState = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
        builder: (BuildContext context, TaskState state) {
      if (state is TasksLoading) {
        return Center(child: CircularProgressIndicator());
      }

      final tasksToShow =
          state.tasks.where((task) => task.completed != true).toList();

      if (tasksToShow.length == 0) {
        return Container(
          alignment: Alignment.center,
          height: 300,
          child: Text('There are no tasks yet. Go create some!'),
        );
      }

      return ListView.separated(
        itemCount: tasksToShow.length,
        itemBuilder: (context, index) {
          final Model.Task task = tasksToShow[index];

          return Dismissible(
            key: Key('${task.id}_$index'),
            background: _dismissableCompleted(),
            secondaryBackground: _dismissableDeleted(),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                // Remove the item from the data source.
                bloc.add(UpdateTaskEvent(
                  updatedTask: task.copyWith(completed: true),
                ));
                // Show a snackbar. This snackbar could also contain "Undo" actions
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Task completed'),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          bloc.add(UpdateTaskEvent(
                            updatedTask: task.copyWith(completed: false),
                          ));
                        }),
                  ),
                );
              } else if (direction == DismissDirection.endToStart) {
                bloc.add(RemoveTaskEvent(taskId: task.id));
                // Show a snackbar. This snackbar could also contain "Undo" actions
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Task removed'),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          bloc.add(RestoreTaskEvent(
                            index: index,
                            task: task.copyWith(),
                          ));
                        }),
                  ),
                );
              }
            },
            child: Task(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: task,
                );
              },
              task: task,
            ),
          );
        },
        separatorBuilder: (_, __) => Divider(),
      );
    });
  }

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
}
