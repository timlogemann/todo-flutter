import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:todone/models/index.dart';

abstract class TaskEvent extends Equatable {
  TaskEvent([List props = const []]) : super(props);
}

class AddTaskEvent extends TaskEvent {
  final Task task;

  AddTaskEvent({
    @required this.task,
  }) : super([task]);

  @override
  String toString() =>
      'LoginEvent: RequestLoginButtonPressed { todo: ${task.todo}, id: ${task.id}, dueDate: ${task.dueDate}, project: ${task.project} }';
}

class RemoveTaskEvent extends TaskEvent {}

class UpdateTaskEvent extends TaskEvent {}

class ToggleTaskEvent extends TaskEvent {}
