import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/tasks/domain/entities/app_task.dart';
import 'package:todo_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_app/util/util.dart';

class CustomAlertDialog extends StatelessWidget {
  CustomAlertDialog({
    Key? key,
    required this.titleController,
    required this.descController,
    required this.edit,
    this.index,
  }) : super(key: key);

  TextEditingController titleController;
  TextEditingController descController;
  bool edit;
  int? index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      if (state is LoadedHistory) {
        return AlertDialog(
          scrollable: true,
          title: Align(
            alignment: Alignment.center,
            child: Text(
              edit ? 'Editar tarefa' : 'Adicionar tarefa',
              style: const TextStyle(fontSize: 25),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: descController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding:
              const EdgeInsets.only(right: 20, left: 20, bottom: 10),
          actions: [
            GestureDetector(
              onTap: () async {
                context.read<TasksBloc>().add(
                      StoreTaskEvent(
                        task: AppTask(
                          id: edit
                              ? state.history[index!].id
                              : '${titleController.text} - ${DateTime.now()}',
                          title: titleController.text,
                          description: descController.text,
                          isDone: edit ? state.history[index!].isDone : false,
                        ),
                      ),
                    );
                await Future.delayed(const Duration(milliseconds: 1));
                context.read<TasksBloc>().add(GetHistoryEvent());
                Navigator.of(context).pop();
              },
              child: Text(
                edit ? 'Editar' : 'Adicionar',
                style: const TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
          ],
        );
      }
      return Util.errorWidget;
    });
  }
}
