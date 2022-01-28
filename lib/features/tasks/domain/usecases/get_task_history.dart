import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/domain/entities/app_task.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';

class GetTaskHistory implements UseCase<List<AppTask>, NoParams> {
  final TaskRepository repository;

  GetTaskHistory(this.repository);

  @override
  Future<Either<Failure, List<AppTask>>> call(NoParams params) async =>
      await repository.getTaskHistory();
}
