import 'package:go_router/go_router.dart';

import '../features/tasks/presentation/tasks_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: TasksScreen.path,
      builder: (context, state) => const TasksScreen(),
    ),
  ],
);
