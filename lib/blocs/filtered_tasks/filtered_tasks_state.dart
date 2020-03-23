import 'package:equatable/equatable.dart';
import 'package:todone/models/index.dart';

abstract class FilteredTasksState extends Equatable {
  FilteredTasksState();

  @override
  List<Object> get props => [];
}

class FilteredTasksLoading extends FilteredTasksState {}

class FilteredTasksLoaded extends FilteredTasksState {
  final List<Task> filteredTasks;
  final VisibilityFilter activeFilter;

  FilteredTasksLoaded(
    this.filteredTasks,
    this.activeFilter,
  );

  @override
  List<Object> get props => [filteredTasks, activeFilter];

  @override
  String toString() {
    return 'FilteredTasksLoadSuccess { filteredTasks: $filteredTasks, activeFilter: $activeFilter }';
  }
}
