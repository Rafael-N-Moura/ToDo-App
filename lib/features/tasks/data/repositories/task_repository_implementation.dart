import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/exception.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/sucess/sucess.dart';
import 'package:todo_app/features/tasks/data/datasources/task_local_data_source.dart';
import 'package:todo_app/features/tasks/domain/entities/app_task.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImplementation implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImplementation({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Sucess>> storeTask(AppTask task) async {
    try {
      final sucess = LocalDatabaseSucess();
      await localDataSource.storeTask(task);
      return Right(sucess);
    } on LocalDatabaseException {
      return Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<AppTask>>> getTaskHistory() async {
    try {
      final taskList = await localDataSource.getTaskHistory();
      return Right(taskList);
    } on LocalDatabaseException {
      return Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Sucess>> deleteTask(String taskId) async {
    try {
      final sucess = LocalDatabaseSucess();
      await localDataSource.deleteTask(taskId);
      return Right(sucess);
    } on LocalDatabaseException {
      return Left(LocalDatabaseFailure());
    }
  }
}
