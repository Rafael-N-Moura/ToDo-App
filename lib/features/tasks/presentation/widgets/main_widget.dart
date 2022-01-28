import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_app/features/tasks/presentation/widgets/no_data_widget.dart';
import 'package:todo_app/features/tasks/presentation/widgets/task_widget.dart';
import 'package:todo_app/util/util.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      if (state is Loading) {
        return Util.loadingWidget;
      }
      if (state is LoadedHistory) {
        if (state.history.isEmpty) {
          return const NoDataWidget();
        } else {
          return ListView.builder(
            itemCount: state.history.length,
            itemBuilder: (context, index) {
              return TaskWidget(
                index: index,
              );
            },
          );
        }
      }
      if (state is Error) {
        return Center(
          child: Text(state.message),
        );
      }
      return Util.errorWidget;
    });
  }
}
