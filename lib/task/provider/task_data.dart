import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:productivity_local/constant.dart';
import 'package:productivity_local/task/models/task.dart';
import 'package:http/http.dart' as http;
import 'package:productivity_local/task/models/task.dart';

class TaskData extends ChangeNotifier {
  final box = GetStorage();

  List<Task> tasks = [];
  String? encodeString = '';

  void addTask(String newTaskName, String newTaskSubtitle) async {
    // String id = DateTime.now().toString();
    // tasks.add(Task(
    //     id: id.toString(),
    //     title: newTaskName,
    //     subtitle: newTaskSubtitle,
    //     createdAt:
    //         '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'));
    // box.write('tasks', Task.encode(tasks));
    final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/tasks"),
        body: {
          // "id": id.toString(),
          "title": newTaskName,
          "subtitle": newTaskSubtitle,
          "user_id": '1',
          "is_done": '0'
          //     '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
        });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    getTasks();
    notifyListeners();
  }

  checkTask(Task tsk)async {
    // tsk.Done();
    var response = await http
        .put(Uri.parse('http://127.0.0.1:8000/api/tasks/${tsk.id}'),
        body: {
          'is_done':  tsk.isDone == 0 ? '1' : '0' ,
    });
    print(response.body);
    print('updated');
    getTasks();
    notifyListeners();
  }

  deletingTask(Task tsk) async {
    tasks.remove(tsk);

    final response = await http.post(
        Uri.parse("https://productivite.000webhostapp.com/delete_todo.php"),
        body: {
          "id": tsk.id,
        });
    if (response.statusCode == 200) {
      print('deleted');
      box.write('tasks', Task.encode(tasks));
      notifyListeners();
    }
  }

  Future getTasks() async {
    var response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/tasks'));

    print('response1 = ' + response.statusCode.toString());
    print('body = ' + response.body.toString());

    // if (response.statusCode != 200) {
    //   while (response.statusCode != 200) {
    //     response = await http.get(
    //         Uri.parse('http://127.0.0.1:8000/api/taks'));
    //     print('trying');
    //   }
    //
    //   print('response2 = ' + response.statusCode.toString());
    //
    //
    // }
    tasks = Task.decode(response.body.toString());

    notifyListeners();
  }
}
