import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tests/core/theme/theme_controller.dart';
import 'package:tests/core/widgets/custom_svg_picture.dart';
import 'package:tests/features/home/home_controller.dart';
import 'package:tests/features/add_task/add_task.dart';
import 'package:tests/features/home/components/archieved_tasks_widget.dart';
import 'package:tests/features/home/components/high_priority_tasks_widget.dart';
import 'package:tests/features/home/components/sliver_task_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeController()..init(),
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 40,
          width: 167,
          child: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
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
                    context.read<HomeController>().loadTasks();
                  }
                },
                label: Text("Add New Task"),
                icon: Icon(Icons.add),
              );
            },
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
                          Selector<HomeController, String?>(
                            selector: (BuildContext context, controller) =>
                                controller.userImagePath,
                            builder:
                                (
                                  BuildContext context,
                                  String? userImagePath,
                                  Widget? child,
                                ) {
                                  return CircleAvatar(
                                    backgroundImage: userImagePath == null
                                        ? AssetImage("assets/images/person.png")
                                        : FileImage(File(userImagePath!)),
                                  );
                                },
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Selector<HomeController, String?>(
                                selector:
                                    (
                                      BuildContext context,
                                      HomeController controller,
                                    ) => controller.username,
                                builder:
                                    (
                                      BuildContext context,
                                      String? username,
                                      Widget? child,
                                    ) {
                                      return Text(
                                        "Good Evening ,$username",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      );
                                    },
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
                      ArchievedTasksWidget(),
                      SizedBox(height: 8),
                      HighPriorityTasksWidget(),
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
              SliverTaskListWidget(emptyMesseage: "No Data"),
            ],
          ),
        ),
      ),
    );
  }
}
