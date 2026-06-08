import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tests/models/task_model.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];

  String? username = "Default";
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;
  String? userImagePath;

  void init() {
    loadUserData();
    loadTasks();
  }

  Future<void> loadUserData() async {
    username = PreferencesManagers().getString(StorageKey.username);
    userImagePath = PreferencesManagers().getString(StorageKey.userImage);
    notifyListeners();
  }

  Future<void> loadTasks() async {
    isLoading = true;
    final finalTask = PreferencesManagers().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      final task = taskAfterDecode.map((element) {
        return TaskModel.fromJson(element);
      }).toList();

      tasks = task;
      calculatePercent();
    }
    isLoading = false;
    notifyListeners();
  }

  void calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  void donTasks(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calculatePercent();
    notifyListeners();

    final updatedTask = tasks.map((element) => element.toJson()).toList();

    await PreferencesManagers().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );
  }

  void deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((task) => task.id == id);
    calculatePercent();
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManagers().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }
}
