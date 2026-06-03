import 'dart:convert';

import 'package:flutter/material.dart';

import '../core/services/preferences_manager.dart';
import '../models/task_model.dart';
import '../widgets/task_list_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> todoTasks = [];
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
    final finalTask = PreferencesManagers().getString("tasks");
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      final task = taskAfterDecode
          .map((element) {
            return TaskModel.fromJson(element);
          })
          .where((element) => element.isDone == false)
          .toList();

      setState(() {
        todoTasks = task;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;

    final finalTask = PreferencesManagers().getString("tasks");
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      tasks.removeWhere((e) => e.id == id);
    }
    setState(() {
      todoTasks.removeWhere((el) => el.id == id);
    });
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManagers().setString("tasks", jsonEncode(updatedTask));
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
                tasks: todoTasks,
                onTap: (value, index) async {
                  setState(() {
                    todoTasks[index!].isDone = value ?? false;
                  });

                  final allData = PreferencesManagers().getString("tasks");

                  if (allData != null) {
                    List<TaskModel> allDataList = (jsonDecode(allData) as List)
                        .map((element) => TaskModel.fromJson(element))
                        .toList();
                    final int newIndex = allDataList.indexWhere(
                      (e) => e.id == todoTasks[index!].id,
                    );
                    allDataList[newIndex] = todoTasks[index!];

                    await PreferencesManagers().setString(
                      "tasks",
                      jsonEncode(allDataList),
                    );

                    _loadTasks();
                  }
                },
                emptyMesseage: "No Tasks Found",
                onDelete: (int? id) {
                  _deleteTask(id);
                },
              ),
      ),
    );
  }
}
