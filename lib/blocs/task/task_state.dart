import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:todone/models/index.dart';

abstract class TaskState extends Equatable {
  final List<Task> tasks = [
    Task('Duinzigt bellen', 'Woning', DateTime.utc(2020, 03, 17)),
    Task('Flutter leren', 'Development', DateTime.utc(2020, 03, 20),
        'dat wil ik graag')
  ];

  TaskState([List props = const []]) : super(props);
}

class TasksInitial extends TaskState {
  @override
  String toString() => 'TaskInitial';
}

class TasksLoadings extends TaskState {
  @override
  String toString() => 'TasksLoading';
}

class AddTask extends TaskState {
  final Task task;

  AddTask({@required this.task}) : super([task]);

  @override
  String toString() => 'AddTask';
}
