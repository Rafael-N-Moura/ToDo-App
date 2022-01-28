import 'package:bloc/bloc.dart';
import 'package:todo_app/core/usecases/usecase.dart';

import 'package:todo_app/features/tasks/domain/entities/app_task.dart';
import 'package:todo_app/features/tasks/domain/usecases/delete_task.dart';
import 'package:todo_app/features/tasks/domain/usecases/get_task_history.dart';
import 'package:todo_app/features/tasks/domain/usecases/store_task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

const String LOCAL_DATABASE_FAILURE =
    'Ocorreu um erro e as informações não puderam ser carreagadas!';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final DeleteTask deleteTaskUC;
  final StoreTask storeTaskUC;
  final GetTaskHistory getTaskHistoryUC;

  TasksBloc(
    this.deleteTaskUC,
    this.storeTaskUC,
    this.getTaskHistoryUC,
  ) : super(Loading()) {
    on<GetHistoryEvent>(getTaskHistory);
    on<DeleteTaskEvent>(deleteTask);
    on<StoreTaskEvent>(storeTask);
  }

  void getTaskHistory(GetHistoryEvent event, Emitter<TasksState> emit) async {
    emit(Loading());
    final history = await getTaskHistoryUC(NoParams());
    history.fold(
        (failure) => emit(
              Error(message: LOCAL_DATABASE_FAILURE),
            ), (sucessHistory) {
      emit(
        LoadedHistory(history: sucessHistory),
      );
    });
  }

  void storeTask(StoreTaskEvent event, Emitter<TasksState> emit) async {
    emit(Loading());
    final result = await storeTaskUC(TaskParams(task: event.task));
    result.fold(
        (failure) => emit(
              Error(message: LOCAL_DATABASE_FAILURE),
            ),
        (sucess) => {});
  }

  void deleteTask(DeleteTaskEvent event, Emitter<TasksState> emit) async {
    emit(Loading());
    final history = await deleteTaskUC(IdTaskParams(taskId: event.taskId));
    history.fold(
        (failure) => emit(
              Error(message: LOCAL_DATABASE_FAILURE),
            ),
        (sucessHistory) => {});
  }
}
