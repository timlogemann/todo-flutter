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
      'AddTaskEvent: creating task { todo: ${task.todo}, id: ${task.id}, dueDate: ${task.dueDate}, project: ${task.project} }';
}

class RemoveTaskEvent extends TaskEvent {
  final int taskId;

  RemoveTaskEvent({
    @required this.taskId,
  }) : super([taskId]);

  @override
  String toString() => 'RemoveTaskEvent: removing task with id: $taskId }';
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  UpdateTaskEvent({
    @required this.task,
  }) : super([task]);

  @override
  String toString() =>
      'UpdateTaskEvent: updating task { todo: ${task.todo}, id: ${task.id}, dueDate: ${task.dueDate}, project: ${task.project} }';
}

class RestoreTaskEvent extends TaskEvent {
  final int index;
  final Task task;

  RestoreTaskEvent({
    @required this.index,
    @required this.task,
  }) : super([index, task]);

  @override
  String toString() =>
      'RestoreTaskEvent: restoring task ${task.todo} at index $index';
}

class ToggleTaskEvent extends TaskEvent {}
