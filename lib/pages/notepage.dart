import 'package:flutter/material.dart';

import '../component/navBar.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
      ),
      bottomNavigationBar: const NavBar(
        currItem: 2,
      ),
    );
  }
}
