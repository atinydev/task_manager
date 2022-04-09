import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:task_manager/src/features/tasks/domain/task.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier()
      : super(
          [],
        );

  void create({
    required String title,
    bool isComplete = false,
    DateTime? date,
    String? comments,
    String? description,
    List<String>? tags,
  }) {
    state = [
      ...state,
      Task(
        id: UniqueKey().toString(),
        title: title,
        isComplete: isComplete,
        date: date,
        comments: comments,
        description: description,
        tags: tags,
      )
    ];
  }

  void update({
    required String id,
    required String title,
    bool isComplete = false,
    DateTime? date,
    String? comments,
    String? description,
    List<String>? tags,
  }) {
    state = [
      for (final task in state)
        if (task.id == id)
          task.copyWith(
            id: id,
            title: title,
            isComplete: isComplete,
            date: date,
            comments: comments,
            description: description,
            tags: tags,
          )
    ];
  }

  void remove({required Task target}) {
    state = state.where((task) => task.id != target.id).toList();
  }
}
