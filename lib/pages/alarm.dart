import 'package:clock_app/pages/world_clock.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              Navigator.pushNamedAndRemoveUntil(
                  context, WorldClock.routeName, (r) => false);
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Material(
            child: Container(
              margin: const EdgeInsets.all(6),
              child: SwitchListTile(
                activeColor: const Color.fromARGB(255, 0, 217, 246),
                secondary: const Icon(
                  Icons.alarm,
                ),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      "09:30",
                      style: GoogleFonts.lato(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                subtitle: Container(
                  child: Text(
                    "Weekends",
                    style: GoogleFonts.roboto(
                      fontSize: 15
                    ),
                  ),
                  margin: const EdgeInsets.only(top: 2.0),
                ),
                onChanged: (bool value) {
                  value = !value;
                },
                value: true,
              ),
            ),
          ),
          const Divider(),
        ],
      ),
      bottomNavigationBar: const NavBar(
        currItem: 1,
      ),
    );
  }
}
