import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tests/core/widgets/custom_text_form_field.dart';
import 'package:tests/features/add_task/add_task_controller.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (BuildContext context) => AddTaskController(),
      child: Builder(
        builder: (context) {
          final controller = context.read<AddTaskController>();
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Form(
                  key: controller.key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: controller.taskNameController,
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
                        controller: controller.taskDescriptionController,
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
                          Consumer<AddTaskController>(
                            builder:
                                (BuildContext context, value, Widget? child) {
                                  return Switch(
                                    value: value.isHighPriority,
                                    onChanged: (bool value) {
                                      controller.toggle(value);
                                    },
                                  );
                                },
                          ),
                        ],
                      ),
                      Spacer(),
                      ElevatedButton.icon(
                        onPressed: () async {
                          controller.addTask(context);
                        },
                        label: Text("Add Task"),
                        icon: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
