import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/sucess/sucess.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/domain/usecases/delete_task.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late DeleteTask usecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = DeleteTask(mockTaskRepository);
  });

  final tTaskId = 'test';
  Sucess sucess = LocalDatabaseSucess();

  test(
    'should call the repository to delete a task in the local database',
    () async {
      when(mockTaskRepository)
          .calls(#deleteTask)
          .thenAnswer((_) async => Right<Failure, Sucess>(sucess));

      final result = await usecase(IdTaskParams(taskId: tTaskId));

      expect(result, Right(sucess));
      verify(mockTaskRepository).called(#deleteTask);
      verify(mockTaskRepository).called(#storeTask).times(0);
      verify(mockTaskRepository).called(#getTaskHistory).times(0);
    },
  );
}
