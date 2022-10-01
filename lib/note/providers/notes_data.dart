import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:productivity_local/note/models/note.dart';
import '../../constant.dart';
import 'package:http/http.dart' as http;

class NotesData with ChangeNotifier {
  final box = GetStorage();
  bool getColor = false;
  List<Note> notes = [];
  String? encodeString = '';
  int color = 0xffb71c1c;

  changeColor(int newColor) {
    color = newColor;
    notifyListeners();
  }

  updateColor(Note note, int newColor) {
    note.color = newColor.toString();
    notifyListeners();
  }

  Future index() async {
    var response = await http.get(Uri.parse('http://127.0.0.1:8000/api/notes'));
    notes = Note.decode(response.body.toString());
    print(response.body);
    notifyListeners();
  }

  void store(BuildContext context, String newNotesName, int color) async {
    await http.post(Uri.parse("http://127.0.0.1:8000/api/notes"), body: {
      "title": newNotesName,
      "color": color.toString(),
      'user_id': '1',
    });
    notes.add(Note(
        title: newNotesName,
        color: color.toString(),
        dateTime: DateTime.now(),
        id: notes.length + 1));
    Navigator.pop(context);
    notifyListeners();
  }

  update(BuildContext context, Note note, String title) async {
     await http
        .put(Uri.parse("http://127.0.0.1:8000/api/notes/${note.id}"), body: {
      "title": title,
      'color': note.color.toString(),
    });
    notes.firstWhere((element) => element.id == note.id).title = title;
    notes.firstWhere((element) => element.id == note.id).color = note.color;
    Navigator.pop(context);
    notifyListeners();
  }

  destroy(Note note) async {
    notes.remove(note);
    box.write('notes', Note.encode(notes));
    await http.post(
        Uri.parse("https://productivite.000webhostapp.com/delete_note.php"),
        body: {
          "id": note.id,
        });
    notes.removeWhere((element) => element.id == note.id);
    notifyListeners();
  }

  Future getColors() async {
    primaryClr = await box.read('mode') == true ? Colors.black : Colors.white;
    secondaryClr = Color(box.read('color') ?? 0xff00FFFF);
    getColor = true;
  }
}
