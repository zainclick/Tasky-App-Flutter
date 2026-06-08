import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tests/models/task_model.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class TasksController with ChangeNotifier {
  bool isLoading = false;

  List<TaskModel> tasks = [];
  List<TaskModel> todoTasks = [];
    List<TaskModel> completeTasks = [];
  List<TaskModel> highPriorityTasks = [];

  void init() {
    loadTasks();
  }

  void loadTasks() {
    isLoading = true;
    final finalTask = PreferencesManagers().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();

      todoTasks = tasks.where((element) => !element.isDone).toList();
      completeTasks = tasks.where((element) => element.isDone).toList();
      highPriorityTasks = tasks
          .where((element) => element.isHighPriority)
          .toList();

      //calculatePercent();
    }
    isLoading = false;
    notifyListeners();
  }

  void doneTask(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isDone = value ?? false;

    final int newIndex = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[newIndex] = todoTasks[index];

    await PreferencesManagers().setString(StorageKey.tasks, jsonEncode(tasks));

    loadTasks();
    notifyListeners();
  }

  void doneCompleteTask(bool? value, int? index) async {
    if (index == null) return;
    completeTasks[index].isDone = value ?? false;

    final int newIndex = tasks.indexWhere(
      (e) => e.id == completeTasks[index].id,
    );
    tasks[newIndex] = completeTasks[index];

    await PreferencesManagers().setString(StorageKey.tasks, jsonEncode(tasks));

    loadTasks();
  }

  void doneHighPriorityTask(bool? value, int? index) async {
    if (index == null) return;
    highPriorityTasks[index].isDone = value ?? false;

    final int newIndex = tasks.indexWhere(
      (e) => e.id == highPriorityTasks[index].id,
    );
    tasks[newIndex] = highPriorityTasks[index];

    await PreferencesManagers().setString(StorageKey.tasks, jsonEncode(tasks));

    loadTasks();
    notifyListeners();
  }

  void deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);
    todoTasks.removeWhere((el) => el.id == id);
    completeTasks.removeWhere((el) => el.id == id);
    highPriorityTasks.removeWhere((el) => el.id == id);

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManagers().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }
}
