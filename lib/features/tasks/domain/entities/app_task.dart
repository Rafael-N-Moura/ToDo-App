import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'app_task.g.dart';

@HiveType(typeId: 0)
class AppTask {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  bool isDone;
  AppTask({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppTask &&
        other.id == id &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode;
}
