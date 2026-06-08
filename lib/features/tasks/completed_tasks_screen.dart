import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tests/core/constants/storage_key.dart';
import 'package:tests/core/services/preferences_manager.dart';
import 'package:tests/features/tasks/tasks_controller.dart';

import '../../models/task_model.dart';
import '../../core/components/task_list_widget.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TasksController()..init(),
      child: Builder(
        builder: (context) {
          final controller = context.read<TasksController>();
          return Scaffold(
            appBar: AppBar(title: Text("To Do Tasks")),
            body: Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: controller.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color(0XFFFFFFFF),
                      ),
                    )
                  : Consumer<TasksController>(
                      builder: (BuildContext context, value, Widget? child) {
                        return TaskListWidget(
                          tasks: value.completeTasks,
                          onTap: (value, index) async {
                            controller.doneCompleteTask(value, index);
                          },
                          emptyMesseage: "No Completed Tasks",
                          onDelete: (int? id) {
                            controller.deleteTask(id);
                          },
                          onEdit: () {
                            controller.init();
                          },
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}
