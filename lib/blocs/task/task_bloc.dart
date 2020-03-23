import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:todone/models/index.dart';
import 'task_state.dart';
import 'task_event.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc();

  @override
  TaskState get initialState => TasksInitial();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    print(event.toString());
    if (event is TasksLoaded) {
      // yield* _mapTasksLoadedToState();
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

  // Stream<TaskState> _mapTasksLoadedToState() async* {
  //   try {
  //     final todos = await this.tasksRepository.loadTodos();
  //     yield TasksLoaded(
  //       todos.map(Todo.fromEntity).toList(),
  //     );
  //   } catch (_) {
  //     yield TodosLoadFailure();
  //   }
  // }

  Stream<TaskState> _mapTaskAddedToState(AddTaskEvent event) async* {
    if (state is TasksLoaded || state is TasksInitial) {
      final List<Task> updatedTasks = List.from(state.tasks)..add(event.task);
      yield TasksLoaded(updatedTasks);
      // _saveTodos(updatedTasks);
    }
  }

  Stream<TaskState> _mapTaskUpdatedToState(UpdateTaskEvent event) async* {
    if (state is TasksLoaded || state is TasksInitial) {
      final List<Task> updatedTasks = state.tasks.map((todo) {
        return todo.id == event.updatedTask.id ? event.updatedTask : todo;
      }).toList();

      print(updatedTasks.toString());

      yield TasksLoaded(updatedTasks);
      // _saveTodos(updatedTasks);
    }
  }

  Stream<TaskState> _mapTaskDeletedToState(RemoveTaskEvent event) async* {
    if (state is TasksLoaded || state is TasksInitial) {
      final updatedTasks =
          state.tasks.where((todo) => todo.id != event.taskId).toList();

      print(updatedTasks.toString());

      yield TasksLoaded(updatedTasks);
      // _saveTodos(updatedTasks);
    }
  }

  Stream<TaskState> _mapTaskRestoredToState(RestoreTaskEvent event) async* {
    if (state is TasksLoaded || state is TasksInitial) {
      final updatedTasks = state.tasks.toList();

      updatedTasks.insert(event.index, event.task);

      print(updatedTasks.toString());

      yield TasksLoaded(updatedTasks);
      // _saveTodos(updatedTasks);
    }
  }

  // Stream<TaskState> _mapToggleAllToState() async* {
  //   if (state is TasksLoaded || state is TasksInitial) {
  //     final allComplete =
  //         state.tasks.every((task) => task.completed);
  //     final List<Task> updatedTasks = state
  //         .tasks
  //         .map((task) => task.copyWith(complete: !allComplete))
  //         .toList();
  //     yield TasksLoaded(updatedTasks);
  //     // _saveTodos(updatedTasks);
  //   }
  // }

  // Stream<TaskState> _mapClearCompletedToState() async* {
  //   if (state is TasksLoaded || state is TasksInitial) {
  //     final List<Todo> updatedTasks =
  //         state.tasks.where((todo) => !todo.complete).toList();
  //     yield TasksLoaded(updatedTasks);
  //     // _saveTodos(updatedTasks);
  //   }
  // }

  // Future _saveTodos(List<Todo> todos) {
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
