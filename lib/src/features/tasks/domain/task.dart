import 'dart:convert';

import 'tags.dart';
import '../presentation/date_controller.dart';

class Task {
  final int? id;
  final String title;
  final bool isComplete;
  final DateTime? date;
  final String? comments;
  final String? description;
  final Tags? tags;

  const Task({
    this.id,
    required this.title,
    required this.isComplete,
    this.date,
    this.comments,
    this.description,
    this.tags,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'title': title,
      'is_completed': isComplete.toInt(),
      'due_date': date?.toDateFormat(),
      'comments': comments,
      'description': description,
      'tags': tags?.toJoinByComma(),
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    final task = Task(
      id: map['id'],
      title: map['title'],
      isComplete:
          map['is_completed'] != null ? toBool(map['is_completed']) : false,
      date: map['due_date'] != null ? DateTime.parse(map['due_date']) : null,
      comments: map['comments'],
      description: map['description'],
      tags: map['tags']?.toTags(),
    );
    return task;
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}

extension ToInt on bool {
  int toInt() {
    switch (this) {
      case true:
        return 1;
      default:
        return 0;
    }
  }
}

bool toBool(dynamic value) {
  if (value.runtimeType == String) {
    value = int.parse(value);
  }
  switch (value) {
    case 0:
      return false;
    case 1:
      return true;
    default:
      throw 'Error: Convert from integer to boolean failed';
  }
}
