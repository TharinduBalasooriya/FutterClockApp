import 'package:clock_app/pages/todo.dart';
import 'package:flutter/material.dart';

class NewNote extends StatefulWidget {
  static const String routeName = '/note';
  const NewNote({Key? key}) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: const [
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter Note Title",
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0)),
              style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black12),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter Description",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0)),
            ),
          ],
        )),
      ),
    );
  }
}
