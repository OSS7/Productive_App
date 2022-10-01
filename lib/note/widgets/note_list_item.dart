import 'package:flutter/material.dart';
import 'package:productivity_local/constant.dart';
import 'package:productivity_local/note/providers/notes_data.dart';
import 'package:provider/provider.dart';

class NoteListItem extends StatelessWidget {
  int? index;
  NoteListItem({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _notes = Provider.of<NotesData>(context, listen: true);
    Color clr = Color(int.parse(_notes.notes[index!].color!));
    return Container(
      decoration: BoxDecoration(
          color: clr.withOpacity(0.95),
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            stops: [0.0002, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [clr.withOpacity(0.5), clr],
          )),
      padding: EdgeInsets.all(30),
      margin: EdgeInsets.all(10),
      // width: size.width * 0.2,
      height: size.height * 0.4,
      child: (_notes.notes[index!].title!.length) < 70
          ? Column(
              children: [
                Expanded(
                  flex: 11,
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        '${_notes.notes[index!].title}',
                        style: TextStyle(fontSize: 20, color: primaryClr),
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Text(
                    '${_notes.notes[index!].dateTime}',
                    style: TextStyle(color: primaryClr.withOpacity(1), fontSize: 11),
                  ),
                  alignment: Alignment.topLeft,
                )
              ],
            )
          : Column(
              children: [
                Expanded(
                  // flex: 1,
                  child: Center(
                    child: Text(
                      '${_notes.notes[index!].title!.substring(0, 90)}...',
                      style: TextStyle(fontSize: 12, color: primaryClr),
                    ),
                  ),
                ),
                Align(
                  child: Text(
                    '${_notes.notes[index!].dateTime}',
                    style: TextStyle(fontSize: 11, color: primaryClr.withOpacity(1)),
                  ),
                  alignment: Alignment.topLeft,
                )
              ],
            ),
    );
  }
}
