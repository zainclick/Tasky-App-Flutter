import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tests/core/widgets/custom_check_box.dart';
import 'package:tests/features/home/home_controller.dart';
import 'package:tests/models/task_model.dart';
import 'package:tests/core/components/task_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  SliverTaskListWidget({super.key, this.emptyMesseage});

  final String? emptyMesseage;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, controller, Widget? child) {
        final taskList = controller.tasks;
        return controller.isLoading
            ? SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(color: Color(0XFFFFFFFF)),
                ),
              )
            : taskList.isEmpty
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
                  itemCount: taskList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TaskItemWidget(
                        model: taskList[index],
                        onChanged: (bool? value) {
                          controller.donTasks(value, index);
                        },
                        onDelete: (int? id) {
                          controller.deleteTask(id);
                        },
                        onEdit: () {
                          controller.loadTasks();
                        },
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
