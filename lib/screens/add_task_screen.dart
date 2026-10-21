import 'package:flutter/material.dart';

/// Part 3: a form with validation. When the form is valid, close the screen
/// and return (title, course) with context.pop((title, course)).
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _course = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _course.dispose();
    super.dispose();
  }

  void _save() {
    // TODO(3.3): if _formKey.currentState!.validate() is true,
    // return the trimmed values with context.pop((title, course)).
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TODO(3.1): TextFormField for the title, labelText 'Title'.
              //   Error if shorter than 3 characters (after trim):
              //   'Title must be at least 3 characters'
              // TODO(3.2): TextFormField for the course, labelText 'Course'.
              //   Error if empty (after trim): 'Please enter a course'
              const SizedBox(height: 24),
              FilledButton(onPressed: _save, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
