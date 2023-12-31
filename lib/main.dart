import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Screens/notes_app_screen.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Notes App",
      debugShowCheckedModeBanner: false,
      home: NotesAppScreen(),
    );
  }
}

