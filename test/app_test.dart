// Lab 3 - provided tests. Do NOT change this file; the TAs grade with the original.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab03_study_tasks/main.dart';
import 'package:lab03_study_tasks/task.dart';

Future<TaskStore> pumpApp(WidgetTester tester, {List<(String, String)> tasks = const []}) async {
  // A wide test screen: the test font is wider than the phone font.
  tester.view.physicalSize = const Size(800, 1200);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  final store = TaskStore();
  for (final (title, course) in tasks) {
    store.add(title, course);
  }
  await tester.pumpWidget(StudyTasksApp(store: store));
  await tester.pumpAndSettle();
  return store;
}

Future<void> openAddScreen(WidgetTester tester) async {
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
}

Future<void> fillAndSave(WidgetTester tester, String title, String course) async {
  await tester.enterText(find.widgetWithText(TextFormField, 'Title'), title);
  await tester.enterText(find.widgetWithText(TextFormField, 'Course'), course);
  await tester.tap(find.text('Save'));
  await tester.pumpAndSettle();
}

void main() {
  group('Part 2 - home screen', () {
    testWidgets('shows the title and an empty message', (tester) async {
      await pumpApp(tester);
      expect(find.text('Study Tasks'), findsOneWidget);
      expect(find.text('No tasks yet'), findsOneWidget);
    });

    testWidgets('lists existing tasks in a ListView with title and course', (tester) async {
      await pumpApp(tester, tasks: [('Read chapter 3', 'COMP 205'), ('Solve sheet 2', 'MATH 201')]);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.widgetWithText(ListTile, 'Read chapter 3'), findsOneWidget);
      expect(find.text('MATH 201'), findsOneWidget);
    });
  });

  group('Part 1+3 - navigation to the form and validation', () {
    testWidgets('the add button opens the "Add task" screen', (tester) async {
      await pumpApp(tester);
      await openAddScreen(tester);
      expect(find.text('Add task'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('empty form shows both error messages', (tester) async {
      await pumpApp(tester);
      await openAddScreen(tester);
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.text('Title must be at least 3 characters'), findsOneWidget);
      expect(find.text('Please enter a course'), findsOneWidget);
      expect(find.text('Add task'), findsOneWidget, reason: 'must stay on the form');
    });

    testWidgets('a two-letter title is rejected', (tester) async {
      await pumpApp(tester);
      await openAddScreen(tester);
      await fillAndSave(tester, 'ab', 'COMP 205');
      expect(find.text('Title must be at least 3 characters'), findsOneWidget);
    });

    testWidgets('a valid form goes back and the new task is listed', (tester) async {
      final store = await pumpApp(tester);
      await openAddScreen(tester);
      await fillAndSave(tester, 'Prepare P0', 'COMP 205');
      expect(find.text('Add task'), findsNothing);
      expect(find.widgetWithText(ListTile, 'Prepare P0'), findsOneWidget);
      expect(store.tasks, hasLength(1));
    });

    testWidgets('going back without saving adds nothing', (tester) async {
      final store = await pumpApp(tester);
      await openAddScreen(tester);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('No tasks yet'), findsOneWidget);
      expect(store.tasks, isEmpty);
    });
  });

  group('Part 4 - detail screen', () {
    testWidgets('tapping a task shows its details', (tester) async {
      await pumpApp(tester, tasks: [('Read chapter 3', 'COMP 205')]);
      await tester.tap(find.text('Read chapter 3'));
      await tester.pumpAndSettle();
      expect(find.text('Course: COMP 205'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('delete removes the task and returns to the list', (tester) async {
      final store = await pumpApp(tester, tasks: [('Read chapter 3', 'COMP 205')]);
      await tester.tap(find.text('Read chapter 3'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(find.text('No tasks yet'), findsOneWidget);
      expect(store.tasks, isEmpty);
    });

    testWidgets('the detail screen reads the id from the route /task/:id', (tester) async {
      await pumpApp(tester, tasks: [('First', 'A'), ('Second', 'B')]);
      await tester.tap(find.text('Second'));
      await tester.pumpAndSettle();
      expect(find.text('Course: B'), findsOneWidget);
      expect(find.text('Course: A'), findsNothing);
    });
  });
}
