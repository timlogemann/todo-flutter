import 'dart:async';
import 'package:bloc/bloc.dart';
import 'task_state.dart';
import 'task_event.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc();

  @override
  TaskState get initialState {
    return TasksInitial();
  }

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is AddTaskEvent) {
      print('event');
      print(event);
      yield TaskAdded(tasks: [...state.tasks, event.task]);
      yield TasksLoaded();
    }

    if (event is RemoveTaskEvent) {
      final tasks = [...state.tasks];

      tasks.removeWhere((task) => task.id != event.taskId);

      yield TaskRemoved(tasks: tasks);
      yield TasksLoaded();
    }

    if (event is UpdateTaskEvent) {
      final index = state.tasks.indexWhere((task) => task.id == event.task.id);

      final tasks = [...state.tasks];

      tasks.replaceRange(index, index + 1, [event.task]);

      yield TaskUpdated(tasks: tasks);
      yield TasksLoaded();
    }

    if (event is ToggleTaskEvent) {
      // yield ToggleTask();The type 'AddTask' implied by the 'yield' expression must be assignable to 'Stream<TaskState>'
    }
  }
}
