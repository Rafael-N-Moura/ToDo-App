import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/error/failure.dart';

import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/domain/entities/app_task.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/domain/usecases/get_task_history.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late GetTaskHistory usecase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = GetTaskHistory(mockTaskRepository);
  });

  final List<AppTask> tTaskList = [
    AppTask(id: 'test', title: 'test', description: 'test', isDone: false)
  ];

  test(
    'should get task history from the repository',
    () async {

      when(mockTaskRepository)
          .calls(#getTaskHistory)
          .thenAnswer((_) async => Right<Failure, List<AppTask>>(tTaskList));
      
      final result = await usecase(NoParams());

      expect(result, Right(tTaskList));
      verify(mockTaskRepository).called(#getTaskHistory);
      verify(mockTaskRepository).called(#storeTask).times(0);
      verify(mockTaskRepository).called(#deleteTask).times(0);
     
    },
  );
}
