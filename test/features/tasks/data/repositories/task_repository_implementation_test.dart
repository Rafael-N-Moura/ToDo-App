import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/tasks/data/datasources/task_local_data_source.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository_implementation.dart';
import 'package:todo_app/features/tasks/domain/entities/app_task.dart';

class MockLocalDataSource extends Mock implements TaskLocalDataSource {}

void main() {
  late TaskRepositoryImplementation repository;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = TaskRepositoryImplementation(
      localDataSource: mockLocalDataSource,
    );
  });

  void a;

  group(
    'storeTask',
    () {
      final task = AppTask(
          description: 'test', id: 'test', title: 'test', isDone: false);

      test(
        'should check if the local data source is called to store the task',
        () async {
          when(mockLocalDataSource)
              .calls(#storeTask)
              .thenAnswer((_) async => a);

          await repository.storeTask(task);

          verify(mockLocalDataSource).called(#storeTask);
          verify(mockLocalDataSource).called(#getTaskHistory).times(0);
          verify(mockLocalDataSource).called(#deleteTask).times(0);
        },
      );
    },
  );

  group(
    'deleteTask',
    () {
      final taskId = 'test';

      test(
        'should check if the local data source is called to delete the task',
        () async {
          when(mockLocalDataSource)
              .calls(#deleteTask)
              .thenAnswer((_) async => a);

          await repository.deleteTask(taskId);

          verify(mockLocalDataSource).called(#deleteTask);
          verify(mockLocalDataSource).called(#getTaskHistory).times(0);
          verify(mockLocalDataSource).called(#storeTask).times(0);
        },
      );
    },
  );

  group(
    'getHistory',
    () {
      List<AppTask> tList = [
        AppTask(id: 'test', title: 'test', description: 'test', isDone: false)
      ];

      test(
        'should check if we get the history',
        () async {
          when(mockLocalDataSource)
              .calls(#getTaskHistory)
              .thenAnswer((_) async => tList);

          final result = await repository.getTaskHistory();

          expect(result, tList);

          verify(mockLocalDataSource).called(#getTaskHistory);
          verify(mockLocalDataSource).called(#deleteTask).times(0);
          verify(mockLocalDataSource).called(#storeTask).times(0);
        },
      );
    },
  );
}
