import 'package:flutter/material.dart';

import '../task.dart';

/// Part 4: shows one task; the id comes from the route /task/:id.
class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.store, required this.id});

  final TaskStore store;
  final int id;

  @override
  Widget build(BuildContext context) {
    // TODO(4.2): find the task with store.byId(id). If it is null, show
    //   'Task not found'. Otherwise show (inside Padding 16, in a Column):
    //   - the title (Theme.of(context).textTheme.headlineSmall)
    //   - 'Course: <course>'
    //   - an OutlinedButton.icon with Icons.delete and the label 'Delete'
    // TODO(4.3): Delete removes the task (store.remove) and goes back (context.pop()).
    return Scaffold(
      appBar: AppBar(title: const Text('Task')),
      body: Center(child: Text('Task $id - TODO')),
    );
  }
}
