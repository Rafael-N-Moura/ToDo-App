import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/features/tasks/data/datasources/task_local_data_source.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository_implementation.dart';
import 'package:todo_app/features/tasks/domain/usecases/delete_task.dart';
import 'package:todo_app/features/tasks/domain/usecases/get_task_history.dart';
import 'package:todo_app/features/tasks/domain/usecases/store_task.dart';
import 'package:todo_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_app/util/util.dart';

import 'features/tasks/domain/entities/app_task.dart';
import 'features/tasks/presentation/pages/home_page.dart';

var setup =
    TaskRepositoryImplementation(localDataSource: TaskLocalDataSource());

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<AppTask>(AppTaskAdapter());
  await Hive.openBox<AppTask>(Util.taskHistoryBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TasksBloc(DeleteTask(setup), StoreTask(setup), GetTaskHistory(setup)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Nunito',
        ),
        home: const HomePage(),
      ),
    );
  }
}
