import 'dart:convert';

class Task {
  int? id;
  final String? title;
  final String? subtitle;
  int? isDone;
  DateTime? createdAt;

  Task({this.id, this.title,
    this.subtitle,
    this.isDone ,
    this.createdAt});

  void Done() {
    isDone == 0 ? true : false ;
  }

  factory Task.fromjson(Map<String, dynamic> jsonData) {
    return Task(
      id: jsonData['id'],
      title: jsonData['title'],
      subtitle: jsonData['subtitle'],
      isDone: jsonData['is_done'],
      createdAt: DateTime.parse(jsonData['created_at']),
      // createdAt: DateTime.parse(jsonData['created_at']),
    );
  }
  static Map<String, dynamic>? toMap(Task task) => {
        'id': task.id,
        'title': task.title,
        'subtitle': task.subtitle,
        'is_done': task.isDone,
        'created_at': task.createdAt,
  };

  static String encode(List<Task> task) => json.encode(
        task.map<Map<String, dynamic>?>((tasks) => Task.toMap(tasks)).toList(),
      );

  static List<Task> decode(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map<Task>((task) => Task.fromjson(task))
          .toList();
}
