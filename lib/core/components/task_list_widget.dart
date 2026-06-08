import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tests/core/widgets/custom_check_box.dart';
import 'package:tests/models/task_model.dart';
import 'package:tests/core/components/task_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    this.emptyMesseage,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(int?) onDelete;
  final Function onEdit;

  final String? emptyMesseage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyMesseage ?? "No Data",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.only(bottom: 50),
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TaskItemWidget(
                  model: tasks[index],
                  onChanged: (bool? value) {
                    onTap(value, index);
                  },
                  onDelete: (int? id) {
                    onDelete(id);
                  },
                  onEdit: () {
                    onEdit();
                  },
                ),
              );
            },
          );
  }
}
