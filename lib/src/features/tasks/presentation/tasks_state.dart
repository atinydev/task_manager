import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/src/hardcode/hardcode.dart';

import '../domain/task.dart';
import 'tasks_controller.dart';

final tasksProvider =
    StateNotifierProvider.autoDispose<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});

final currentTaskProvider =
    Provider.autoDispose.family<Task?, String?>((ref, target) {
  if (target == HardCode.text.tempId) {
    return null;
  }
  return ref.watch(tasksProvider).firstWhere((task) => task.id == task.id);
});
