import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain/task.dart';
import '../domain/tags.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  void create({
    required String title,
    bool isComplete = false,
    DateTime? date,
    String? comments,
    String? description,
    String? tags,
  }) {
    if (comments != null && comments.isEmpty) comments = null;
    if (description != null && description.isEmpty) description = null;
    if (tags != null && tags.isEmpty) tags = null;
    state = [
      ...state,
      Task(
        id: UniqueKey().toString(),
        title: title,
        isComplete: isComplete,
        date: date,
        comments: comments,
        description: description,
        tags: tags?.toTags(),
      ),
    ];
  }

  void toggle({required Task target}) {
    state = [
      for (final task in state)
        if (task.id == target.id)
          Task(
            id: task.id,
            title: task.title,
            isComplete: !task.isComplete,
            date: task.date,
            comments: task.comments,
            description: task.description,
            tags: task.tags,
          )
        else
          task,
    ];
  }

  void update({
    required String id,
    required String title,
    bool isComplete = false,
    DateTime? date,
    String? comments,
    String? description,
    String? tags,
  }) {
    if (comments != null && comments.isEmpty) comments = null;
    if (description != null && description.isEmpty) description = null;
    if (tags != null && tags.isEmpty) tags = null;
    state = [
      for (final task in state)
        if (task.id == id)
          Task(
            id: id,
            title: title,
            isComplete: isComplete,
            date: date,
            comments: comments,
            description: description,
            tags: tags?.toTags(),
          )
        else
          task,
    ];
  }

  void remove({required Task target}) {
    state = state.where((task) => task.id != target.id).toList();
  }
}

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});
