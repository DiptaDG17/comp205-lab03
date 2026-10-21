/// A study task. Given in the starter - you do not need to change it.
class Task {
  const Task({required this.id, required this.title, required this.course});

  final int id;
  final String title;
  final String course;
}

/// Keeps the tasks in memory while the app runs. Given in the starter.
class TaskStore {
  final List<Task> _tasks = [];
  int _nextId = 1;

  List<Task> get tasks => List.unmodifiable(_tasks);

  Task add(String title, String course) {
    final task = Task(id: _nextId++, title: title, course: course);
    _tasks.add(task);
    return task;
  }

  Task? byId(int id) {
    for (final t in _tasks) {
      if (t.id == id) return t;
    }
    return null;
  }

  void remove(int id) => _tasks.removeWhere((t) => t.id == id);
}
