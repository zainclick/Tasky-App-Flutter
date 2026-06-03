import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tests/core/widgets/custom_check_box.dart';
import 'package:tests/models/task_model.dart';
import 'package:tests/widgets/task_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    this.emptyMesseage,
    required this.onDelete,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(int?) onDelete;

  final String? emptyMesseage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                emptyMesseage ?? "No Data",
                style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 20),
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.only(bottom: 80),
            sliver: SliverList.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TaskItemWidget(
                    model: tasks[index],
                    onChanged: (bool? value) {
                      onTap(value, index);
                    },
                    onDelete: (int? id) {
                      onDelete(id);
                    },
                  ),
                );
              },
            ),
          );
  }
}
