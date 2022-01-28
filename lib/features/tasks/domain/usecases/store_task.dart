import 'package:dartz/dartz.dart';

import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/sucess/sucess.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/domain/entities/app_task.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';

class StoreTask implements UseCase<Sucess, TaskParams> {
  final TaskRepository repository;

  StoreTask(this.repository);

  @override
  Future<Either<Failure, Sucess>> call(TaskParams params) async =>
      await repository.storeTask(params.task);
}

class TaskParams {
  final AppTask task;

  TaskParams({required this.task});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskParams && other.task == task;
  }

  @override
  int get hashCode => task.hashCode;
}
