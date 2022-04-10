import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/src/features/tasks/presentation/task_view_controller.dart';

import 'date_controller.dart';
import 'task_create_edit_screen.dart';
import 'current_task_controller.dart';
import '../domain/task.dart';
import '../../../hardcode/hardcode.dart';
import 'tasks_controller.dart';

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
      padding: const EdgeInsets.only(top: 4),
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
        ref.read(currentTaskProvider.notifier).updateState(task);
        ref.read(dateProvider.notifier).updateState(task.date);
        context.pushNamed(TaskCreateEditScreen.name, params: {
          'id': task.id.toString(),
        });
      },
      child: Dismissible(
        onDismissed: (direction) {
          ref.read(tasksProvider.notifier).remove(target: task);
        },
        key: Key(task.id.toString()),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: task.isComplete,
                onChanged: (value) {
                  ref.read(taskViewController).toggle(target: task);
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    if (task.description != null) ...[
                      const SizedBox(height: 5),
                      Text(
                        task.description!,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (task.date != null) ...[
                      const SizedBox(height: 5),
                      Text(
                        task.date!.toDateVisual(),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (task.tags != null) ...[
                      const SizedBox(height: 5),
                      _TagsWidget(task: task),
                    ],
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

class _TagsWidget extends StatelessWidget {
  const _TagsWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: task.tags!.stringTags
          .map(
            (stringTag) => Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                "#$stringTag",
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          )
          .toList(),
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
