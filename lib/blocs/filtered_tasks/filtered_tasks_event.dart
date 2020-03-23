import 'package:equatable/equatable.dart';
import 'package:todone/models/index.dart';

abstract class FilteredTasksEvent extends Equatable {
  FilteredTasksEvent();
}

class FilterUpdatedEvent extends FilteredTasksEvent {
  final VisibilityFilter filter;

  FilterUpdatedEvent(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdatedEvent { filter: $filter }';
}

class TasksUpdatedEvent extends FilteredTasksEvent {
  final List<Task> tasks;

  TasksUpdatedEvent(this.tasks);

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'TasksUpdatedEvent { tasks: $tasks }';
}
