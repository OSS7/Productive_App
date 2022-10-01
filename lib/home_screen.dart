
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:productivity_local/constant.dart';
import 'package:productivity_local/data.dart';
import 'package:productivity_local/note/providers/notes_data.dart';
import 'package:productivity_local/note/screens/notes_screen.dart';
import 'package:productivity_local/note/widgets/loading_circle.dart';
import 'package:productivity_local/setting/screens/setting_screen.dart';
import 'package:productivity_local/task/provider/task_data.dart';
import 'package:productivity_local/task/screens/tasks_screen.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _widgetScreens = [
    NotesScreen(),
    TasksScreen(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NotesData>(context,listen: false);
    final tasks = Provider.of<TaskData>(context,listen: false);

    return FutureBuilder(
      future: Future.wait([
        notes.getColors(),
        notes.index(),
        tasks.getTasks()
      ]) ,
      builder: (context,snap) {
        return notes.getColor ?  Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
            child: _widgetScreens.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey,
            items: const [

              BottomNavigationBarItem(
                icon: Icon(Icons.note_add),
                label: 'Notes',
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box),
                label: 'Todo',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
                backgroundColor: Colors.green,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: secondaryClr,
            onTap: _onItemTapped,
          )
        ):Scaffold(
          backgroundColor: primaryClr,
          body: const Center(
            child: LoadingCircle(),
          ),
        );
      }
    );
  }
}