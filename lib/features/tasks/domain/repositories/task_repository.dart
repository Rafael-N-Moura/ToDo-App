import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/sucess/sucess.dart';
import 'package:todo_app/features/tasks/domain/entities/app_task.dart';

abstract class TaskRepository {
  Future<Either<Failure, Sucess>> storeTask(AppTask task);
  Future<Either<Failure, List<AppTask>>> getTaskHistory();
  Future<Either<Failure, Sucess>> deleteTask(String taskId);
}
