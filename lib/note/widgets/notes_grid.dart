import 'package:flutter/material.dart';
import 'package:productivity_local/constant.dart';
import 'package:productivity_local/note/providers/notes_data.dart';
import 'package:productivity_local/note/widgets/note_list_item.dart';
import 'package:provider/provider.dart';

class NotesGrid extends StatefulWidget {
  final bool direction;
  const NotesGrid({Key? key, required this.direction}) : super(key: key);

  @override
  State<NotesGrid> createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {

  SliverGridDelegateWithFixedCrossAxisCount isVertical() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 1,
        childAspectRatio: 1.3);
  }

  SliverGridDelegateWithFixedCrossAxisCount isHorizontal() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 5,
        crossAxisSpacing: 1,
        childAspectRatio: 1.8);
  }
  @override
  Widget build(BuildContext context) {
    final _notes = Provider.of<NotesData>(context, listen: true);

    return Container(
      padding: const EdgeInsets.all(0),
      height: 200,
      decoration: BoxDecoration(
        color: primaryClr,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        child: GridView.builder(
          scrollDirection:
          widget.direction ? Axis.vertical : Axis.horizontal,
          gridDelegate: widget.direction ? isVertical() : isHorizontal(),
          itemCount: _notes.notes.length,
          itemBuilder: (ctx, i) => GestureDetector(
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text(
                          'This note will be deleted \n Are you sure?'),
                      actions: [
                        MaterialButton(
                            child: const Text('no'),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        MaterialButton(
                            child: const Text('ok'),
                            onPressed: () {
                              _notes.destroy(_notes.notes[i]);
                              Navigator.pop(context);
                            }),
                      ],
                    ));
              },
              onTap: () {
                Navigator.pushNamed(context, '/AddNoteScreen',
                    arguments: {'note': _notes.notes[i]});
              },
              child: NoteListItem(
                index: i,
              )),
        ),
      ),
    );
  }
}
