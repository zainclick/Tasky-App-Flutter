import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tests/features/tasks/completed_tasks_screen.dart';
import 'package:tests/features/home/home_screen.dart';
import 'package:tests/features/profile/profile_screen.dart';
import 'package:tests/features/tasks/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screen = [
    HomeScreen(),
    TasksScreen(),
    CompletedTasksScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/home.svg", 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/todo.svg", 1),
            label: "To Do",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/completed.svg", 2),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/profile.svg", 3),
            label: "Profile",
          ),
        ],
      ),
      body: _screen[_currentIndex],
    );
  }

  SvgPicture _buildSvgPicture(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentIndex == index ? Color(0XFF15B86C) : Color(0XFFC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
