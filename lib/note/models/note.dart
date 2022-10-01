import 'dart:convert';

class Note {
  int? id;
  String? title;
  String? color;
  DateTime? dateTime;

  Note({required this.id, required this.title,required this.color,
    this.dateTime
  });

  factory Note.fromJson(Map<String, dynamic> jsonData) {
    return Note(
      id: jsonData['id'],
      title: jsonData['title'],
      color: jsonData['color'],
      dateTime: DateTime.parse(jsonData['created_at']),
    );
  }

  static Map<String, dynamic>? toMap(Note note) => {
    'id' : note.id,
    'title': note.title,
    'color': note.color,
    'created_at': note.dateTime,
  };

  static String encode(List<Note> notes) => json.encode(
    notes.map<Map<String, dynamic>?>((note) => Note.toMap(note)).toList(),
  );

  static List<Note> decode(String note) =>
      (json.decode(note) as List<dynamic>)
          .map<Note>((item) => Note.fromJson(item))
          .toList();

  bool checkIfAnyIsNull() {
    return [id,title, color,dateTime].contains(null);
  }

}