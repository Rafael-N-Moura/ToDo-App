part of 'tasks_bloc.dart';

abstract class TasksEvent {
  const TasksEvent();
}

class GetHistoryEvent extends TasksEvent {}

class StoreTaskEvent extends TasksEvent {
  final AppTask task;
  StoreTaskEvent({
    required this.task,
  });
}

class DeleteTaskEvent extends TasksEvent {
  final String taskId;
  DeleteTaskEvent({
    required this.taskId,
  });
}
