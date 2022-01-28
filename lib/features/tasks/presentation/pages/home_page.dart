import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_app/features/tasks/presentation/widgets/custom_alert_dialog.dart';
import 'package:todo_app/features/tasks/presentation/widgets/main_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<TasksBloc>().add(GetHistoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => CustomAlertDialog(
                titleController: TextEditingController(),
                descController: TextEditingController(),
                edit: false,
              ),
            );
          },
        ),
        appBar: AppBar(
          title: const Text("ToDo"),
          centerTitle: true,
        ),
        body: MainWidget(),
      );
    });
  }
}
