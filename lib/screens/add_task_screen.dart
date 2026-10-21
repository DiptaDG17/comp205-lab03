import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    if (_formKey.currentState!.validate()) {
      context.pop((_title.text.trim(), _course.text.trim()));
    }
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
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.trim().length < 3) {
                    return 'Title must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // TODO(3.2): TextFormField for the course, labelText 'Course'.
              //   Error if empty (after trim): 'Please enter a course'
              TextFormField(
                controller: _course,
                decoration: const InputDecoration(labelText: 'Course'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a course';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton(onPressed: _save, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
