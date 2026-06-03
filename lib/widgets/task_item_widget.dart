import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tests/core/enums/task_item_actions_enum.dart';
import 'package:tests/core/theme/theme_controller.dart';
import 'package:tests/models/task_model.dart';

import '../core/services/preferences_manager.dart';
import '../core/widgets/custom_check_box.dart';
import '../core/widgets/custom_text_form_field.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
  });

  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int?) onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0XFFD1DAD6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) {
              onChanged(value);
            },
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                model.taskName,
                style: model.isDone
                    ? Theme.of(context).textTheme.titleLarge
                    : Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                model.taskDescription,
                style: TextStyle(
                  color: Color(0XFFC6C6C6),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (model.isDone ? Color(0XFFA0A0A0) : Color(0XFFC6C6C6))
                  : (model.isDone ? Color(0XFF6A6A6A) : Color(0XFF3A4640)),
            ),

            onSelected: (value) {
              switch (value) {
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!model.isDone);
                case TaskItemActionsEnum.delete:
                  _showDialog(context);
                case TaskItemActionsEnum.edit:
                  _showModelBottom(context, model);
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
              return PopupMenuItem(value: e, child: Text(e.name));
            }).toList(),
          ),
        ],
      ),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete ${model.taskName}"),
          content: Text("Are you sure delete ${model.taskName} ?"),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("cancel"),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.pop(context);
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  _showModelBottom(BuildContext context, TaskModel model) {
    final GlobalKey<FormState> _key = GlobalKey<FormState>();

    final TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );
    bool isHighPriority = model.isHighPriority;

    final TextEditingController taskDescriptionController =
        TextEditingController(text: model.taskDescription);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: taskNameController,
                      hintText: "Finish UI design for login screen",
                      title: "Task Name",
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please Enter Task Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      title: "Task Description",
                      controller: taskDescriptionController,
                      hintText:
                          "Finish onboarding UI and hand off to devs by Thursday.",
                      maxLines: 5,
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "High Priority  ",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Switch(
                          value: isHighPriority,
                          onChanged: (bool value) {
                            setState(() {
                              isHighPriority = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (_key.currentState?.validate() == true) {}
                      },
                      label: Text("Update Task"),
                      icon: Icon(Icons.edit),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
