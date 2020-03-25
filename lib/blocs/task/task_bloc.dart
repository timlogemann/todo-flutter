import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todone/blocs/task/task_repository.dart';
import 'package:todone/models/index.dart';
import 'task_state.dart';
import 'task_event.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc({@required this.taskRepository});

  @override
  TaskState get initialState => TasksLoading();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    print(event.toString());
    if (event is TasksLoadedEvent) {
      yield* _mapTasksLoadedToState();
    } else if (event is AddTaskEvent) {
      yield* _mapTaskAddedToState(event);
    } else if (event is UpdateTaskEvent) {
      yield* _mapTaskUpdatedToState(event);
    } else if (event is RemoveTaskEvent) {
      yield* _mapTaskDeletedToState(event);
    } else if (event is RestoreTaskEvent) {
      yield* _mapTaskRestoredToState(event);
    }
  }

  Stream<TaskState> _mapTasksLoadedToState() async* {
    try {
      final tasks = await this.taskRepository.loadTasks();
      yield TasksLoaded(
        tasks.map(Task.fromEntity).toList(),
      );
    } catch (_) {
      yield TasksLoadedFailed();
    }
  }

  Stream<TaskState> _mapTaskAddedToState(AddTaskEvent event) async* {
    if (state is TasksLoaded) {
      final List<Task> updatedTasks = List.from(state.tasks)..add(event.task);
      yield TasksLoaded(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TaskState> _mapTaskUpdatedToState(UpdateTaskEvent event) async* {
    if (state is TasksLoaded) {
      final List<Task> updatedTasks = state.tasks.map((todo) {
        return todo.id == event.updatedTask.id ? event.updatedTask : todo;
      }).toList();

      print(updatedTasks.toString());

      yield TasksLoaded(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TaskState> _mapTaskDeletedToState(RemoveTaskEvent event) async* {
    if (state is TasksLoaded) {
      final updatedTasks =
          state.tasks.where((todo) => todo.id != event.taskId).toList();

      print(updatedTasks.toString());

      yield TasksLoaded(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TaskState> _mapTaskRestoredToState(RestoreTaskEvent event) async* {
    if (state is TasksLoaded) {
      final updatedTasks = state.tasks.toList();

      updatedTasks.insert(event.index, event.task);

      print(updatedTasks.toString());

      yield TasksLoaded(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Future _saveTasks(List<Task> tasks) {
    return taskRepository.saveTasks(
      tasks.map((task) => task.toEntity()).toList(),
    );
  }

  // Stream<TaskState> _mapToggleAllToState() async* {
  //   if (state is TasksLoaded) {
  //     final allComplete =
  //         state.tasks.every((task) => task.completed);
  //     final List<Task> updatedTasks = state
  //         .tasks
  //         .map((task) => task.copyWith(complete: !allComplete))
  //         .toList();
  //     yield TasksLoaded(updatedTasks);
  //     _saveTasks(updatedTasks);
  //   }
  // }

  // Stream<TaskState> _mapClearCompletedToState() async* {
  //   if (state is TasksLoaded) {
  //     final List<Todo> updatedTasks =
  //         state.tasks.where((todo) => !todo.complete).toList();
  //     yield TasksLoaded(updatedTasks);
  //     _saveTasks(updatedTasks);
  //   }
  // }

  // Future _saveTasks(List<Todo> todos) {
  // return todosRepository.saveTodos(
  //   todos.map((todo) => todo.toEntity()).toList(),
  // );
  // }

  /*
  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is AddTaskEvent) {
      print('event');
      print(event);
      yield TaskAdded(tasks: [...state.tasks, event.task]);
      yield TasksLoaded(tasks: state.tasks);
    }

    if (event is RemoveTaskEvent) {
      final tasks = [...state.tasks];

      tasks.removeWhere((task) => task.id == event.taskId);

      yield TaskRemoved(tasks: tasks);
      yield TasksLoaded(tasks: state.tasks);
    }

    if (event is UpdateTaskEvent) {
      final index = state.tasks.indexWhere((task) => task.id == event.task.id);

      final tasks = [...state.tasks];

      tasks.replaceRange(index, index + 1, [event.task]);

      yield TaskUpdated(tasks: tasks);
      yield TasksLoaded(tasks: state.tasks);
    }

    if (event is ToggleTaskEvent) {
      // yield ToggleTask();The type 'AddTask' implied by the 'yield' expression must be assignable to 'Stream<TaskState>'
    }

    if (event is RestoreTaskEvent) {
      final tasks = [...state.tasks];

      tasks.insert(event.index, event.task);

      yield TaskRestored(tasks: tasks);
      yield TasksLoaded(tasks: state.tasks);
    }
  }
  */
}
