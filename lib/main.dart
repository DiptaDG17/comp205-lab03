import 'package:flutter/material.dart';

import 'router.dart';
import 'task.dart';

void main() {
  runApp(StudyTasksApp(store: TaskStore()));
}

class StudyTasksApp extends StatelessWidget {
  StudyTasksApp({super.key, required this.store});

  final TaskStore store;
  late final _router = createRouter(store);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Study Tasks',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      routerConfig: _router,
    );
  }
}
