import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tests/core/enums/task_item_actions_enum.dart';
import 'package:tests/core/theme/theme_controller.dart';
import 'package:tests/models/task_model.dart';

import '../constants/storage_key.dart';
import '../services/preferences_manager.dart';
import '../widgets/custom_check_box.dart';
import '../widgets/custom_text_form_field.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int?) onDelete;
  final Function onEdit;

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

            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!model.isDone);
                case TaskItemActionsEnum.delete:
                  _showDialog(context);
                case TaskItemActionsEnum.edit:
                  final result = await _showModelBottom(context, model);
                  if (result == true) {
                    onEdit();
                  }
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
}

Future<bool?> _showModelBottom(BuildContext context, TaskModel model) {
  TextEditingController taskNameController = TextEditingController(
    text: model.taskName,
  );
  TextEditingController taskDescriptionController = TextEditingController(
    text: model.taskDescription,
  );
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool isHighPriority = model.isHighPriority;
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  CustomTextFormField(
                    controller: taskNameController,
                    title: "Task Name",
                    hintText: 'Finish UI design for login screen',
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please Enter Task Name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    title: "Task Description",
                    controller: taskDescriptionController,
                    maxLines: 5,
                    hintText:
                        'Finish onboarding UI and hand off to devs by Thursday.',
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'High Priority',
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
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    ),
                    onPressed: () async {
                      if (key.currentState?.validate() ?? false) {
                        final taskJson = PreferencesManagers().getString(
                          StorageKey.tasks,
                        );

                        List<dynamic> listTasks = [];

                        if (taskJson != null) {
                          listTasks = jsonDecode(taskJson);
                        }

                        TaskModel newModel = TaskModel(
                          id: model.id,
                          taskName: taskNameController.text,
                          taskDescription: taskDescriptionController.text,
                          isHighPriority: isHighPriority,
                          isDone: model.isDone,
                        );

                        final item = listTasks.firstWhere(
                          (e) => e['id'] == model.id,
                        );

                        final int index = listTasks.indexOf(item);
                        listTasks[index] = newModel;

                        final taskEncode = jsonEncode(listTasks);
                        await PreferencesManagers().setString(
                          StorageKey.tasks,
                          taskEncode,
                        );

                        Navigator.of(context).pop(true);
                      }
                    },
                    label: Text('Edit Task'),
                    icon: Icon(Icons.edit),
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
