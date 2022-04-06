import 'package:clock_app/pages/newnote.dart';
import 'package:clock_app/pages/world_clock.dart';
import 'package:clock_app/widgets/noteCardWidget.dart';
import 'package:flutter/material.dart';

import '../component/navBar.dart';

class ToDoList extends StatefulWidget {
  static const String routeName = '/todo';
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, WorldClock.routeName, (r) => false);
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView(
                    children: const [
                      NoteCardWidget(),
                      NoteCardWidget(),
                      NoteCardWidget(),
                      NoteCardWidget(),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NewNote()),
                    );
                  },
                  child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey,
                      ),
                      child: const Icon(Icons.add)),
                )),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(
        currItem: 2,
      ),
    );
  }
}
