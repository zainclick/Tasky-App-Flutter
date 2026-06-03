import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tests/core/services/preferences_manager.dart';
import 'package:tests/core/widgets/custom_text_form_field.dart';
import 'package:tests/models/task_model.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // Todo: DISPOSE THIS CONTROLLERS
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
        titleTextStyle: TextStyle(
          color: Color(0XFFFFFCFC),
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    if (_key.currentState?.validate() ?? false) {
                      final taskJson = PreferencesManagers().getString("tasks");
                      List<Map<String, dynamic>> listTasks = [];
                      if (taskJson != null) {
                        listTasks = List<Map<String, dynamic>>.from(
                          jsonDecode(taskJson),
                        );
                      }

                      TaskModel model = TaskModel(
                        id: listTasks.length + 1,
                        taskName: taskNameController.text,
                        taskDescription: taskDescriptionController.text,
                        isHighPriority: isHighPriority,
                      );

                      listTasks.add(model.toJson());
                      final taskEncode = jsonEncode(listTasks);

                      await PreferencesManagers().setString(
                        "tasks",
                        taskEncode,
                      );

                      Navigator.of(context).pop(true);
                    }
                  },
                  label: Text("Add Task"),
                  icon: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
