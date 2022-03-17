import 'package:clock_app/pages/world_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/navBar.dart';

class Alarm extends StatefulWidget {
  static const String routeName = '/alarm';
  const Alarm({Key? key}) : super(key: key);

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              // handle the press
              Navigator.pushNamedAndRemoveUntil(context, WorldClock.routeName, (r) => false);
            },
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(
        currItem: 1,
      ),
    );
  }
}
