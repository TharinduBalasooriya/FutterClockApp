import 'dart:developer';

import 'package:clock_app/pages/alarm.dart';
import 'package:clock_app/pages/reminder.dart';
import 'package:clock_app/pages/todo.dart';
import 'package:clock_app/pages/world_clock.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final int currItem;
  const NavBar({
    Key? key,
    required this.currItem,
  }) : super(key: key);
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currItem;
  }

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          Navigator.of(context).pushNamed(WorldClock.routeName);
          break;
        case 1:
          Navigator.of(context).pushNamed(Alarm.routeName);
          break;
        case 2:
          Navigator.of(context).pushNamed(ToDoList.routeName);
          break;
        case 3:
          Navigator.of(context).pushNamed(Reminder.routeName);
          break;

        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.language_sharp), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.library_books), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: ''),
      ],
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.white,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
