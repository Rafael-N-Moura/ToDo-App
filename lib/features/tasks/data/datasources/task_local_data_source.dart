import 'package:hive/hive.dart';
import 'package:todo_app/core/error/exception.dart';
import 'package:todo_app/features/tasks/domain/entities/app_task.dart';
import 'package:todo_app/util/util.dart';

class TaskLocalDataSource {
  Box<AppTask> tasksBox = Hive.box<AppTask>(Util.taskHistoryBoxName);
  List<AppTask> history = [];

  Future<List<AppTask>> getTaskHistory() {
    history.clear();
    if (tasksBox.isNotEmpty) {
      for (var key in tasksBox.keys) {
        var task = tasksBox.get(key);
        if (task != null) {
          history.add(task);
        } else {
          throw LocalDatabaseException();
        }
      }
    }
    return Future.value(history);
  }

  Future<void> storeTask(AppTask task) {
    return tasksBox.put(task.id, task);
  }

  Future<void> deleteTask(String idTask) {
    return tasksBox.delete(idTask);
  }
}
