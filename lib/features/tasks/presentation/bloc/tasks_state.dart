part of 'tasks_bloc.dart';

abstract class TasksState {
  const TasksState();
}

class Loading extends TasksState {}

class LoadedHistory extends TasksState {
  final List<AppTask> history;

  LoadedHistory({required this.history});
}

class Error extends TasksState {
  final String message;
  Error({
    required this.message,
  });
}
