import 'package:flutter/material.dart';

import '../task.dart';

/// Part 2: the list of tasks.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.store});

  final TaskStore store;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _addTask() async {
    // TODO(2.3): open '/add' with context.push<(String, String)>('/add').
    // The form returns (title, course) when the user saves, or null.
    // If not null: setState(() => widget.store.add(...)).
  }

  // ignore: unused_element (you will call it in TODO 2.1)
  Future<void> _openTask(Task task) async {
    // TODO(4.1): open '/task/<id>' with context.push, then call setState(() {})
    // afterwards (the task may have been deleted on the detail screen).
  }

  @override
  Widget build(BuildContext context) {
    final tasks = widget.store.tasks;
    return Scaffold(
      appBar: AppBar(title: const Text('Study Tasks')),
      // TODO(2.1): if tasks is empty show Center(Text('No tasks yet')),
      // otherwise a ListView.builder with one ListTile per task
      // (title: task.title, subtitle: task.course, onTap: () => _openTask(task)).
      body: Center(child: Text('${tasks.length} tasks - TODO: show the list')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add task',
        onPressed: _addTask, // TODO(2.3) is inside _addTask
        child: const Icon(Icons.add),
      ),
    );
  }
}
