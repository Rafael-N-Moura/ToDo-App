import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_app/features/tasks/presentation/widgets/custom_alert_dialog.dart';
import 'package:todo_app/util/util.dart';

class TaskWidget extends StatelessWidget {
  TaskWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      if (state is LoadedHistory) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Material(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 8.0, left: 8, top: 8),
                        child: SingleChildScrollView(
                          child: Text(
                            state.history[index].title,
                            style: const TextStyle(
                                fontSize: 20, fontFamily: 'Nunito-Bold'),
                            softWrap: true,
                          ),
                        ),
                      ),
                      Checkbox(
                          value: state.history[index].isDone,
                          onChanged: (value) {
                            state.history[index].isDone =
                                !state.history[index].isDone;
                            context.read<TasksBloc>().add(
                                  StoreTaskEvent(
                                    task: state.history[index],
                                  ),
                                );
                            context.read<TasksBloc>().add(
                                  GetHistoryEvent(),
                                );
                          })
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0, left: 8),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.history[index].description,
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0, left: 8),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              actionsPadding: const EdgeInsets.only(
                                  right: 20, left: 20, bottom: 10),
                              actions: [
                                GestureDetector(
                                  child: const Text(
                                    'Remover',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onTap: () {
                                    context.read<TasksBloc>().add(
                                        DeleteTaskEvent(
                                            taskId: state.history[index].id));
                                    context
                                        .read<TasksBloc>()
                                        .add(GetHistoryEvent());
                                    Navigator.of(context).pop();
                                  },
                                ),
                                GestureDetector(
                                  child: const Text('Cancelar'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                              content: const Text(
                                  'Tem certeza que deseja remover essa tarefa?'),
                            ),
                          ),
                          child: const Text(
                            'Remover',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => CustomAlertDialog(
                                index: index,
                                edit: true,
                                titleController: TextEditingController(
                                    text: state.history[index].title),
                                descController: TextEditingController(
                                    text: state.history[index].description),
                              ),
                            );
                          },
                          child: const Text(
                            'Editar',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return Util.errorWidget;
    });
  }
}
