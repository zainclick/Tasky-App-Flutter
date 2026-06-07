import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tests/core/constants/storage_key.dart';
import 'package:tests/core/theme/theme_controller.dart';
import 'package:tests/core/widgets/custom_svg_picture.dart';
import 'package:tests/models/task_model.dart';
import 'package:tests/features/add_task/add_task.dart';
import 'package:tests/widgets/archieved_tasks_widget.dart';
import 'package:tests/widgets/high_priority_tasks_widget.dart';
import 'package:tests/widgets/sliver_task_list_widget.dart';

import '../../core/services/preferences_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username = "Default";
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;
  String? userImagePath;

  @override
  void initState() {
    _loadUserName();
    _loadTasks();
    super.initState();
  }

  Future<void> _loadUserName() async {
    setState(() {
      username = PreferencesManagers().getString(StorageKey.username);
      userImagePath = PreferencesManagers().getString(StorageKey.userImage);
    });
  }

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
    });
    final finalTask = PreferencesManagers().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      final task = taskAfterDecode.map((element) {
        return TaskModel.fromJson(element);
      }).toList();

      setState(() {
        tasks = task;
        _calculatePercent();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void _calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  void _donTasks(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calculatePercent();
    });

    final updatedTask = tasks.map((element) => element.toJson()).toList();

    await PreferencesManagers().setString(StorageKey.tasks, jsonEncode(updatedTask));
  }

  void _deleteTask(int? id) async {
    if (id == null) return;

    setState(() {
      tasks.removeWhere((task) => task.id == id);
      _calculatePercent();
    });
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManagers().setString(StorageKey.tasks, jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 40,
        width: 167,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddTask();
                },
              ),
            );
            if (result != null && result) {
              _loadTasks();
            }
          },
          label: Text("Add New Task"),
          icon: Icon(Icons.add),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: userImagePath == null
                              ? AssetImage("assets/images/person.png")
                              : FileImage(File(userImagePath!)),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Evening ,$username ",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "One task at a time.One step closer.",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                          ),
                          child: Center(
                            child: Icon(
                              ThemeController.isDark()
                                  ? Icons.sunny
                                  : Icons.dark_mode,
                              color: ThemeController.isDark()
                                  ? Color(0XFFFFFCFC)
                                  : Color(0XFF161F1B),
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Yuhuu ,Your work Is ",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "almost done ! ",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        CustomSvgPicture.withoutColor(
                          path: "assets/images/waving.svg",
                          height: 23,
                          width: 24,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ArchievedTasksWidget(
                      totalTasks: totalTasks,
                      totalDoneTasks: totalDoneTasks,
                      percent: percent,
                    ),
                    SizedBox(height: 8),
                    HighPriorityTasksWidget(
                      tasks: tasks,
                      onTap: (bool? value, int? index) async {
                        _donTasks(value, index);
                      },
                      refresh: () {
                        _loadTasks();
                      },
                    ),
                    SizedBox(height: 24),
                    Text(
                      "My Tasks",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0XFFFFFFFF),
                      ),
                    ),
                  )
                : SliverTaskListWidget(
                    tasks: tasks,
                    onTap: (value, index) async {
                      _donTasks(value, index);
                    },
                    emptyMesseage: "No Data",
                    onDelete: (int? id) {
                      _deleteTask(id);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
