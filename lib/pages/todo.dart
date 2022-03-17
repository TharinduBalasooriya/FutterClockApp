import 'package:clock_app/pages/world_clock.dart';
import 'package:flutter/material.dart';

import '../component/navBar.dart';

class ToDoList extends StatefulWidget {
  static const String routeName = '/todo';
  const ToDoList({ Key? key }) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Diaries"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, WorldClock.routeName, (r) => false);
            },
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(currItem: 2,),
    );
  }
}