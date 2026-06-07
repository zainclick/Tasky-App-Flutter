import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tests/core/constants/storage_key.dart';
import 'package:tests/core/services/preferences_manager.dart';

import '../models/task_model.dart';
import '../widgets/task_list_widget.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<TaskModel> comletedTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    _loadTasks();
    super.initState();
  }

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
    });
    final finalTask = PreferencesManagers().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      final task = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .where((element) => element.isDone)
          .toList();

      setState(() {
        comletedTasks = task;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;

    final finalTask = PreferencesManagers().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      tasks.removeWhere((e) => e.id == id);
    }
    setState(() {
      comletedTasks.removeWhere((el) => el.id == id);
    });
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManagers().setString(StorageKey.tasks, jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do Tasks")),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0XFFFFFFFF)))
            : TaskListWidget(
                tasks: comletedTasks,
                onTap: (value, index) async {
                  setState(() {
                    comletedTasks[index!].isDone = value ?? false;
                  });

                  final allData = PreferencesManagers().getString(StorageKey.tasks);

                  if (allData != null) {
                    List<TaskModel> allDataList = (jsonDecode(allData) as List)
                        .map((element) => TaskModel.fromJson(element))
                        .toList();
                    final int newIndex = allDataList.indexWhere(
                      (e) => e.id == comletedTasks[index!].id,
                    );
                    allDataList[newIndex] = comletedTasks[index!];

                    await PreferencesManagers().setString(
                      StorageKey.tasks,
                      jsonEncode(allDataList),
                    );

                    _loadTasks();
                  }
                },
                emptyMesseage: "No Completed Tasks",
                onDelete: (int? id) {
                  _deleteTask(id);
                },
              ),
      ),
    );
  }
}
