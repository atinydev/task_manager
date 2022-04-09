import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'tasks_state.dart';

class TaskCreateEditScreen extends ConsumerWidget {
  const TaskCreateEditScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  static const name = 'Name';
  static const path = 'path';
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(currentTaskProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: (task?.title == null) ? const Text("New task") : null,
        actions: [
          IconButton(
            onPressed: () {
              if (task != null) {
                ref.read(tasksProvider.notifier).remove(target: task);
                context.pop();
              }
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: const [
              // Title
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Enter a title',
                ),
              ),
              // Description
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  icon: Icon(Icons.description),
                  hintText: 'Description',
                ),
              ),
              // Dates
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.date_range),
                  hintText: 'Add date/time',
                ),
              ),
              // Comments
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  icon: Icon(Icons.comment),
                  hintText: 'Comments',
                ),
              ),
              // Tags
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.tag),
                  hintText: 'Tags',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
