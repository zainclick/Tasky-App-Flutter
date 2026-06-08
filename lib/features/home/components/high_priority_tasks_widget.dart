import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tests/core/theme/theme_controller.dart';
import 'package:tests/features/home/home_controller.dart';
import 'package:tests/models/task_model.dart';
import 'package:tests/features/tasks/high_priority_tasks_screen.dart';

import '../../../core/widgets/custom_check_box.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, controller, Widget? child) {
        final taskLists = controller.tasks;
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "High Priority Tasks",
                        style: TextStyle(
                          color: Color(0XFF15B86C),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    ...taskLists.take(4).where((e) => e.isHighPriority).map((
                      element,
                    ) {
                      return Row(
                        children: [
                          CustomCheckBox(
                            value: element.isDone,
                            onChanged: (bool? value) {
                              final index = taskLists.indexWhere(
                                (e) => e.id == element.id,
                              );
                              controller.donTasks(value, index);
                            },
                          ),

                          Expanded(
                            child: Text(
                              element.taskName,
                              style: element.isDone
                                  ? Theme.of(context).textTheme.titleLarge
                                  : Theme.of(context).textTheme.titleMedium,

                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return HighPriorityTasksScreen();
                      },
                    ),
                  );
                  controller.loadTasks();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: ThemeController.isDark()
                            ? Color(0XFF6E6E6E)
                            : Color(0XFFD1DAD6),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SvgPicture.asset(
                      "assets/images/arrow-up.svg",
                      height: 24,
                      width: 24,
                      colorFilter: ColorFilter.mode(
                        ThemeController.isDark()
                            ? Color(0XFFC6C6C6)
                            : Color(0XFF3A4640),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
