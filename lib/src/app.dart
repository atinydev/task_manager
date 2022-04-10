import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'router/router.dart';
import 'theme/theme.dart';
import 'features/tasks/presentation/task_view_controller.dart';

class TaskManagerApp extends ConsumerStatefulWidget {
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends ConsumerState<TaskManagerApp> {
  @override
  void initState() {
    ref.read(taskViewController).initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TaskManagerApp',
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
