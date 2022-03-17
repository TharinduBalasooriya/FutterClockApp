import 'package:clock_app/pages/world_clock.dart';
import 'package:flutter/material.dart';

import '../component/navBar.dart';

class Reminder extends StatefulWidget {
  static const String routeName = '/reminder';
  const Reminder({ Key? key }) : super(key: key);

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminder"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
             Navigator.pushNamedAndRemoveUntil(context, WorldClock.routeName, (r) => false);
            },
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(currItem: 3,),
    );
  }
}