import 'package:flutter/material.dart';
import 'package:productivity_local/constant.dart';
import 'package:productivity_local/note/models/note.dart';
import 'package:productivity_local/note/providers/notes_data.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  List<int> colors = [
    0xffd32f2f,
    0xff00897b,
    0xffd50000,
    0xff009688,
    0xfff44336,
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    Map? arg = ModalRoute.of(context)!.settings.arguments as Map?;
    Note? note = arg!['note'];
    final size = MediaQuery.of(context).size;
    final _notes = Provider.of<NotesData>(context, listen: false);
    TextEditingController _note = TextEditingController();
    int clr = note != null ? int.parse(note.color ?? '') : _notes.color;
    _note.text = (note == null ? '' : note.title)!;

    return Scaffold(
        backgroundColor: primaryClr,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Color(clr),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Text(
                'Add Note',
                style: TextStyle(
                  fontSize: 25,
                  color: Color(clr),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                maxLength: 250,
                maxLines: 20,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(clr), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Color(clr), width: 2),
                  ),
                ),
                style: TextStyle(color: Color(clr), fontSize: 25),
                controller: _note,
                cursorColor: Color(clr),
                autofocus: true,
                cursorHeight: 40,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  // color: Colors.purple,
                  height: 50,
                  width: size.width * 0.9,
                  // alignment: Alignment.center,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: colors.length,
                      itemBuilder: (context, i) {
                        return MaterialButton(
                          onPressed: () {
                            note == null
                                ? _notes.changeColor(colors[i])
                                : _notes.updateColor(note, colors[i]);
                            setState(() {
                              selected = i;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(colors[i]),
                          ),
                        );
                      })),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  if (note == null) {
                    _note.text.isEmpty
                        ? null
                        : _notes.store(context, _note.text.toString(), clr);
                    // Navigator.of(context).pop();
                  } else {
                    _notes.update(context, note, _note.toString());
                    // Navigator.of(context).pop();
                  }
                },
                color: Color(clr),
                child: Text(
                  note == null ? 'Add' : 'Update',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
