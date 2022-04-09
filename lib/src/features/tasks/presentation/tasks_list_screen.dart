import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'task_create_edit_screen.dart';
import 'tasks_state.dart';
import '../domain/task.dart';
import '../../../hardcode/hardcode.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  static const name = 'TasksScreen';
  static const path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: const TaskList(),
      floatingActionButton: const AddTaskButton(),
    );
  }
}

class TaskList extends ConsumerWidget {
  const TaskList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskTile(task: task);
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}

class TaskTile extends ConsumerWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(TaskCreateEditScreen.name, params: {
          'id': task.id,
        });
      },
      child: Dismissible(
        onDismissed: (direction) {
          ref.read(tasksProvider.notifier).remove(target: task);
        },
        key: Key(task.id),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Checkbox(
                value: task.isComplete,
                onChanged: (value) {
                  ref.read(tasksProvider.notifier).toggle(target: task);
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title),
                    const SizedBox(height: 5),
                    if (task.description != null)
                      Text(
                        task.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.pushNamed(TaskCreateEditScreen.name, params: {
          'id': HardCode.text.tempId,
        });
      },
      child: const Icon(Icons.add),
    );
  }
}
