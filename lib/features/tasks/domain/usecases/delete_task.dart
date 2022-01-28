import 'package:dartz/dartz.dart';

import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/sucess/sucess.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';

class DeleteTask implements UseCase<Sucess, IdTaskParams> {
  final TaskRepository repository;

  DeleteTask(this.repository);

  @override
  Future<Either<Failure, Sucess>> call(IdTaskParams params) async =>
      await repository.deleteTask(params.taskId);
}

class IdTaskParams {
  final String taskId;

  IdTaskParams({required this.taskId});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IdTaskParams && other.taskId == taskId;
  }

  @override
  int get hashCode => taskId.hashCode;
}
