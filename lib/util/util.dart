import 'package:flutter/material.dart';

class Util {
  static const taskHistoryBoxName = 'task-history';
  static const loadingWidget = Center(child: CircularProgressIndicator());
  static const errorWidget = Center(
    child: Text(
      "Erro inesperado",
      style: TextStyle(fontSize: 20),
    ),
  );
}
