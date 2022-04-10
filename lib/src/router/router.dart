import 'package:go_router/go_router.dart';

import '../features/tasks/presentation/task_create_edit_screen.dart';
import '../features/tasks/presentation/tasks_list_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: TaskListScreen.path,
      name: TaskListScreen.name,
      builder: (context, state) => const TaskListScreen(),
      routes: [
        GoRoute(
          path: ":id",
          name: TaskCreateEditScreen.name,
          builder: (context, state) {
            return const TaskCreateEditScreen();
          },
        ),
      ],
    ),
  ],
);
