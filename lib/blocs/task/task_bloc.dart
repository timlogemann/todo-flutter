import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:todone/models/task.dart';
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
      yield AddTask(task: event.task);
    }

    if (event is RemoveTaskEvent) {
      // yield RemoveTask(taskId: event.task.id);
    }
    if (event is UpdateTaskEvent) {
      // yield UpdateTask();
    }

    if (event is ToggleTaskEvent) {
      // yield ToggleTask();
    }
  }
}
