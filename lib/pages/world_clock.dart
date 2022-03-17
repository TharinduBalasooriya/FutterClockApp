import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../component/navBar.dart';

class WorldClock extends StatefulWidget {
  static const String routeName = '/worldclock';
  const WorldClock({Key? key}) : super(key: key);

  @override
  State<WorldClock> createState() => _WorldClockState();
}

class _WorldClockState extends State<WorldClock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WorldClock"),
      ),
      bottomNavigationBar: const NavBar(currItem: 0),
    );
  }
}
