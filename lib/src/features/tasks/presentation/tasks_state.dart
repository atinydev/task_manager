import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain/task.dart';
import 'tasks_controller.dart';

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});
