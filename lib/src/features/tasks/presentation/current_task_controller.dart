import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain/task.dart';

class CurrentTaskNotifier extends StateNotifier<Task?> {
  CurrentTaskNotifier() : super(null);

  void updateState(Task? task) {
    state = task;
  }

  void clear() {
    state = null;
  }
}

final currentTaskProvider =
    StateNotifierProvider<CurrentTaskNotifier, Task?>((ref) {
  return CurrentTaskNotifier();
});
