import 'package:go_router/go_router.dart';

import 'screens/add_task_screen.dart';
import 'screens/home_screen.dart';
import 'screens/task_detail_screen.dart';
import 'task.dart';

/// Part 1: the app's routes.
///   /            -> HomeScreen          (given)
///   /add         -> AddTaskScreen       TODO(1.1)
///   /task/:id    -> TaskDetailScreen    TODO(1.2) read the id with state.pathParameters['id']
///
/// Tip: add the two routes as sub-routes of '/' (routes: [...]), so the back
/// button in the app bar returns to the list.
GoRouter createRouter(TaskStore store) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(store: store),
        // TODO(1.1, 1.2): add routes: [ GoRoute(path: 'add', ...), GoRoute(path: 'task/:id', ...) ]
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => const AddTaskScreen(),
          ),
          GoRoute(
            path: 'task/:id',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return TaskDetailScreen(store: store, id: id);
            },
          ),
        ],
      ),
    ],
  );
}