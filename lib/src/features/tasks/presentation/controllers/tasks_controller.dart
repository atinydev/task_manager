import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/task.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  void initState(List<Task> tasks) {
    state = tasks;
  }

  void create({required Task task}) {
    state = [
      ...state,
      task,
    ];
  }

  void update({
    required Task newTask,
    required int id,
  }) {
    state = [
      for (final task in state)
        if (task.id == id) newTask else task,
    ];
  }

  void remove({required Task target}) {
    state = state.where((task) => task.id != target.id).toList();
  }
}

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});
