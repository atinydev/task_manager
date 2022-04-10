import 'tags.dart';

class Task {
  final String id;
  final String title;
  final bool isComplete;
  final DateTime? date;
  final String? comments;
  final String? description;
  final Tags? tags;

  const Task({
    required this.id,
    required this.title,
    required this.isComplete,
    this.date,
    this.comments,
    this.description,
    this.tags,
  });


}
