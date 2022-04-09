import 'package:flutter/material.dart';

class TaskCreateEditScreen extends StatelessWidget {
  const TaskCreateEditScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  static const name = 'Name';
  static const path = 'path';
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name'),
      ),
      body: const Center(
        child: Text('TaskScreen'),
      ),
    );
  }
}
