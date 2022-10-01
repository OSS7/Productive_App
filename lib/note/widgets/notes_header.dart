import 'package:flutter/material.dart';
import 'package:productivity_local/constant.dart';
import 'package:productivity_local/note/providers/notes_data.dart';
import 'package:provider/provider.dart';

class NotesHeader extends StatefulWidget {
  bool direction =false;
  NotesHeader({Key? key,
    required this.direction,
  }) : super(key: key);

  @override
  State<NotesHeader> createState() => _NotesHeaderState();
}

class _NotesHeaderState extends State<NotesHeader> {
  @override
  Widget build(BuildContext context) {
    final _notes = Provider.of<NotesData>(context, listen: false);

    return Container(
      width: double.infinity,
      color: secondaryClr,
      padding: const EdgeInsets.only(
          left: 20, top: 20, right: 1, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              Text(
                'Notes',
                style: TextStyle(
                  color: primaryClr,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${_notes.notes.length} notes",
                style: TextStyle(
                  color: primaryClr,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      widget.direction = !widget.direction;
                    });
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.line_style_sharp,
                      color: secondaryClr,
                    ),
                    backgroundColor: primaryClr,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/AddNoteScreen',
                        arguments: {});
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.add,
                      color: secondaryClr,
                    ),
                    backgroundColor: primaryClr,
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
