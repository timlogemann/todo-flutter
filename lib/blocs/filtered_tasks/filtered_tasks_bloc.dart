import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todone/blocs/filtered_tasks/index.dart';
import 'package:todone/blocs/task/index.dart';
import 'package:todone/models/index.dart';

class FilteredTaskBloc extends Bloc<FilteredTasksEvent, FilteredTasksState> {
  final TaskBloc taskBloc;
  StreamSubscription tasksSubscription;

  FilteredTaskBloc({@required this.taskBloc}) {
    tasksSubscription = taskBloc.listen((state) {
      if (state is TasksLoaded) {
        add(TasksUpdatedEvent((taskBloc.state as TasksLoaded).tasks));
      }
    });
  }

  @override
  FilteredTasksState get initialState {
    return taskBloc.state is TasksLoaded
        ? FilteredTasksLoaded(
            (taskBloc.state as TasksLoaded).tasks,
            VisibilityFilter.all,
          )
        : FilteredTasksLoading();
  }

  @override
  Stream<FilteredTasksState> mapEventToState(FilteredTasksEvent event) async* {
    if (event is FilterUpdatedEvent) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is TasksUpdatedEvent) {
      yield* _mapTasksUpdatedToState(event);
    }
  }

  Stream<FilteredTasksState> _mapUpdateFilterToState(
    FilterUpdatedEvent event,
  ) async* {
    if (taskBloc.state is TasksLoaded) {
      yield FilteredTasksLoaded(
        _mapTasksToFilteredTasks(
          (taskBloc.state as TasksLoaded).tasks,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredTasksState> _mapTasksUpdatedToState(
    TasksUpdatedEvent event,
  ) async* {
    final visibilityFilter = state is FilteredTasksLoaded
        ? (state as FilteredTasksLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredTasksLoaded(
      _mapTasksToFilteredTasks(
        (taskBloc.state as TasksLoaded).tasks,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Task> _mapTasksToFilteredTasks(
      List<Task> tasks, VisibilityFilter filter) {
    return tasks.where((task) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !task.completed;
      } else {
        return task.completed;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    tasksSubscription.cancel();
    return super.close();
  }
}
