import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tests/models/task_model.dart';

class ArchievedTasksWidget extends StatelessWidget {
  const ArchievedTasksWidget({
    super.key,
    required this.totalTasks,
    required this.totalDoneTasks,
    required this.percent,
  });

  final int totalTasks;
  final int totalDoneTasks;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Achieved Tasks",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "$totalDoneTasks Out of $totalTasks Done",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,

              children: [
                Transform.rotate(
                  angle: -pi / 2,
                  child: CircularProgressIndicator(
                    value: percent,
                    valueColor: AlwaysStoppedAnimation(Color(0XFF15B86C)),
                    backgroundColor: Color(0XFF6D6D6D),
                    strokeWidth: 4,
                    strokeAlign: 4,
                  ),
                ),
                Text(
                  "${(percent * 100).toInt()}%",
                  style: Theme.of(context).textTheme.titleMedium
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
