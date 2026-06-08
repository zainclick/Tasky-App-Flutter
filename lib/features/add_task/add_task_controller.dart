import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';
import '../../models/task_model.dart';

class AddTaskController with ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  // Todo: DISPOSE THIS CONTROLLERS
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = false;

  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      final taskJson = PreferencesManagers().getString(StorageKey.tasks);
      List<Map<String, dynamic>> listTasks = [];
      if (taskJson != null) {
        listTasks = List<Map<String, dynamic>>.from(jsonDecode(taskJson));
      }

      TaskModel model = TaskModel(
        id: listTasks.length + 1,
        taskName: taskNameController.text,
        taskDescription: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );

      listTasks.add(model.toJson());
      final taskEncode = jsonEncode(listTasks);

      await PreferencesManagers().setString(StorageKey.tasks, taskEncode);

      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
