import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';

import '../domain/task.dart';

class TasksRepository {
  const TasksRepository();

  static const bearer =
      "e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd";
  static const token = "christian-mv";
  static const authority = "ecsdevapi.nextline.mx";
  static const unencodedPath = "vdev/tasks-challenge";
  static const path = "/tasks";
  static final url = Uri.https(authority, unencodedPath);
  static final baseOptions = BaseOptions(
    baseUrl: url.toString(),
  );
  static final options = Options(
    headers: {
      "Content-Type": 'application/json',
      "authorization": "Bearer: $bearer",
    },
  );

  Future<List<Task>> getTasks() async {
    final response = await Dio(baseOptions).get(
      path,
      queryParameters: {
        'token': token,
      },
      options: options,
    );
    final List<dynamic> listProductsJson = response.data;
    final tasks = listProductsJson.map((task) => Task.fromMap(task)).toList();
    return tasks;
  }

  Future<Task> getTask(Task target) async {
    final response = await Dio(baseOptions).get(
      "$path/${target.id}",
      queryParameters: {
        'token': token,
      },
      options: options,
    );
    final task = Task.fromMap(response.data[0]);
    return task;
  }

  Future<Task> insertTask(Task target) async {
    final queryParameters = target.toMap();
    queryParameters['token'] = token;

    final response = await Dio(baseOptions).post(
      path,
      queryParameters: queryParameters,
      options: options,
    );
    final task = Task.fromMap(response.data['task']);
    return task;
  }

  Future<Task> updateTask(Task target) async {
    final queryParameters = target.toMap();
    queryParameters['token'] = token;

    final response = await Dio(baseOptions).put(
      "$path/${target.id}",
      queryParameters: queryParameters,
      options: options,
    );
    final task = Task.fromMap(response.data['task']);
    return task;
  }

  Future<void> deleteTask(Task target) async {
    final queryParameters = target.toMap();
    queryParameters['token'] = token;

    await Dio(baseOptions).delete(
      "$path/${target.id}",
      queryParameters: {
        'token': token,
      },
      options: options,
    );
  }
}

final tasksRepository = Provider<TasksRepository>(
  (ref) => const TasksRepository(),
);
