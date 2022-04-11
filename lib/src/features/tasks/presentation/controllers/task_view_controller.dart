import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/tasks_repository.dart';
import '../../domain/task.dart';
import '../../domain/tags.dart';
import 'tasks_controller.dart';

class TaskViewController {
  TaskViewController(this.ref);
  final ProviderRef<TaskViewController> ref;

  Future<void> initState() async {
    final tasksId = await ref.read(tasksRepository).getTasks();
    for (var partialTask in tasksId) {
      final fullTask = await ref.read(tasksRepository).getTask(partialTask);
      ref.read(tasksProvider.notifier).create(task: fullTask);
    }
  }

  void create({
    required String title,
    bool isComplete = false,
    DateTime? date,
    String? comments,
    String? description,
    String? tags,
  }) async {
    if (comments != null && comments.isEmpty) comments = null;
    if (description != null && description.isEmpty) description = null;
    if (tags != null && tags.isEmpty) tags = null;
    final task = Task(
      title: title,
      isComplete: isComplete,
      date: date,
      comments: comments,
      description: description,
      tags: tags?.toTags(),
    );
    final newTask = await ref.read(tasksRepository).insertTask(task);
    ref.read(tasksProvider.notifier).create(task: newTask);
  }

  void update({
    required int id,
    required String title,
    bool isComplete = false,
    DateTime? date,
    String? comments,
    String? description,
    String? tags,
  }) async {
    if (comments != null && comments.isEmpty) comments = null;
    if (description != null && description.isEmpty) description = null;
    if (tags != null && tags.isEmpty) tags = null;
    final task = Task(
      id: id,
      title: title,
      isComplete: isComplete,
      date: date,
      comments: comments,
      description: description,
      tags: tags?.toTags(),
    );
    ref.read(tasksRepository).updateTask(task);
    ref.read(tasksProvider.notifier).update(newTask: task, id: id);
  }

  void toggle({
    required Task target,
  }) {
    final task = Task(
      id: target.id,
      title: target.title,
      isComplete: !target.isComplete,
      date: target.date,
      comments: target.comments,
      description: target.description,
      tags: target.tags,
    );
    ref.read(tasksProvider.notifier).update(newTask: task, id: target.id!);
    ref.read(tasksRepository).updateTask(task);
  }

  void remove({required Task target}) {
    ref.read(tasksProvider.notifier).remove(target: target);
    ref.read(tasksRepository).deleteTask(target);
  }
}

final taskViewController = Provider<TaskViewController>((ref) {
  return TaskViewController(ref);
});
