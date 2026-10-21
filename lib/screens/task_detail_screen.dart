import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    final task = store.byId(id);

    if (task == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Task')),
        body: const Center(
          child: Text('Task not found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Course: ${task.course}'),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text('Delete'),
              onPressed: () {
                store.remove(task.id);
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}