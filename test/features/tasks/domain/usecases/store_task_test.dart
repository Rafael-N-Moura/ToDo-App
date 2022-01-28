import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/error/failure.dart';

import 'package:todo_app/core/sucess/sucess.dart';
import 'package:todo_app/features/tasks/domain/entities/app_task.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/domain/usecases/store_task.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late StoreTask usecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = StoreTask(mockTaskRepository);
  });

  final tTask = AppTask(
      id: 'test', title: 'test', description: 'this is a test', isDone: false);
  Sucess sucess = LocalDatabaseSucess();

  test(
    'should call the repository to store a task in the local database',
    () async {
      when(mockTaskRepository)
          .calls(#storeTask)
          .thenAnswer((_) async => Right<Failure, Sucess>(sucess));

      final result = await usecase(TaskParams(task: tTask));

      expect(result, Right(sucess));
      verify(mockTaskRepository).called(#storeTask);
      verify(mockTaskRepository).called(#getTaskHistory).times(0);
      verify(mockTaskRepository).called(#deleteTask).times(0);
    },
  );
}
