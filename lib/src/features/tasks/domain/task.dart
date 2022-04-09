class Task {
  final String id;
  final String title;
  final bool isComplete;
  final DateTime? date;
  final String? comments;
  final String? description;
  final List<String>? tags;

  const Task({
    required this.id,
    required this.title,
    required this.isComplete,
    this.date,
    this.comments,
    this.description,
    this.tags,
  });

  Task copyWith({
    String? id,
    String? title,
    bool? isComplete,
    DateTime? date,
    String? comments,
    String? description,
    List<String>? tags,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isComplete: isComplete ?? this.isComplete,
      date: date ?? this.date,
      comments: comments ?? this.comments,
      description: description ?? this.description,
      tags: tags ?? this.tags,
    );
  }
}
