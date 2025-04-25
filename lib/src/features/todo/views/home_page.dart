import 'package:flutter/material.dart';
import 'package:todoapp/src/features/todo/views/history_task.dart';
import 'package:todoapp/src/features/todo/views/today_task_view.dart';
import 'package:todoapp/src/features/todo/views/upcoming_task.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [TodayTasksView(), HistoryView(), UpcomingView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: "Today"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Upcoming",
          ),
        ],
      ),
    );
  }
}
