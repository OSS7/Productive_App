import 'package:flutter/material.dart';
import 'package:productivity_local/data.dart';
import 'package:productivity_local/home_screen.dart';
import 'package:productivity_local/note/providers/notes_data.dart';
import 'package:productivity_local/note/screens/notes_screen.dart';
import 'package:productivity_local/note/widgets/add_note.dart';
import 'package:productivity_local/setting/providers/setting_data.dart';
import 'package:productivity_local/task/provider/task_data.dart';
import 'package:productivity_local/task/screens/tasks_screen.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(

    providers: [
     ChangeNotifierProvider(create: (context)=>Lists()),
     ChangeNotifierProvider(create: (context)=>NotesData()),
     ChangeNotifierProvider(create: (context)=> TaskData()),
     ChangeNotifierProvider(create: (context)=> SettingData()),
    ],
    child: MaterialApp(
      initialRoute: '/',
      routes:{
        '/AddNoteScreen': (context) => AddNoteScreen(),
        },
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
    );
  }
}
