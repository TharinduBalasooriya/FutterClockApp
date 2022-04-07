import 'dart:developer';

import 'package:clock_app/pages/alarm.dart';
import 'package:clock_app/pages/reminder.dart';
import 'package:clock_app/pages/notes.dart';
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
          Navigator.of(context).pushNamed(AlarmPage.routeName);
          break;
        case 2:
          Navigator.of(context).pushNamed(Notes.routeName);
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
        BottomNavigationBarItem(
            icon: Icon(
              Icons.language_sharp,
              size: 30.0,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm, size: 30.0), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.library_books, size: 30.0), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month, size: 30.0), label: ''),
      ],
      selectedItemColor: const Color.fromARGB(255, 0, 217, 246),
      unselectedItemColor: const Color.fromARGB(255, 175, 180, 192),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
