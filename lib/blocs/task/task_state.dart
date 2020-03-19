import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:todone/models/index.dart';

abstract class TaskState extends Equatable {
  final List<Task> tasks = [
    Task('Duinzigt bellen', 'Woning', DateTime.utc(2020, 03, 17), '', 10),
    Task('Flutter leren', 'Development', DateTime.utc(2020, 03, 20),
        'dat wil ik graag', 15)
  ];

  TaskState([List props = const []]) : super(props);
}

class TasksInitial extends TaskState {
  @override
  String toString() => 'TaskInitial';
}

class TasksLoading extends TaskState {
  final List<Task> tasks = [];

  @override
  String toString() => 'TasksLoading';
}

class TasksLoaded extends TaskState {
  final List<Task> tasks;

  TasksLoaded({@required this.tasks}) : super([tasks]);

  @override
  String toString() => 'TasksLoaded';
}

class TaskAdded extends TaskState {
  final List<Task> tasks;

  TaskAdded({@required this.tasks}) : super([tasks]);

  @override
  String toString() => 'TaskAdded ${tasks.length}';
}

class TaskUpdated extends TaskState {
  final List<Task> tasks;

  TaskUpdated({@required this.tasks}) : super([tasks]);

  @override
  String toString() => 'TaskUpdated ${tasks.length}';
}

class TaskRemoved extends TaskState {
  final List<Task> tasks;

  TaskRemoved({@required this.tasks}) : super([tasks]);

  @override
  String toString() => 'TaskRemoved ${tasks.length}';
}

class TaskRestored extends TaskState {
  final List<Task> tasks;

  TaskRestored({@required this.tasks}) : super([tasks]);

  @override
  String toString() => 'TaskRestored ${tasks.length}';
}
