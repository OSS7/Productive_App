import 'package:flutter/material.dart';
import 'package:productivity_local/constant.dart';
import 'package:productivity_local/note/providers/notes_data.dart';
import 'package:productivity_local/note/widgets/loading_circle.dart';
import 'package:productivity_local/note/widgets/notes_grid.dart';
import 'package:productivity_local/note/widgets/notes_header.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  bool direction = true;

  @override
  Widget build(BuildContext context) {
    final _notes = Provider.of<NotesData>(context, listen: false);

    return Scaffold(
      backgroundColor: secondaryClr,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotesHeader(
            direction: direction,
          ),
          Expanded(
            child: NotesGrid(
              direction: direction,
            ),
          ),
        ],
      ),
    );
  }
}
