import 'package:clock_app/component/alarm_component/single_reminder_component.dart';

import 'package:clock_app/pages/reminder_form.dart';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../component/navBar.dart';
import '../provider/reminder_provider.dart';
import '../services/reminder_service.dart';

class Reminder extends StatefulWidget {
  static const String routeName = '/reminder';
  final ReminderService _reminderService;
  const Reminder({Key? key})
      : _reminderService = const ReminderService(),
        super(key: key);

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  late ReminderService  _reminderService;
  @override
  void initState() {
    super.initState();
     _reminderService = widget. _reminderService;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReminderProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Reminders"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.lock_clock),
              onPressed: () {
                // handle the press
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Reminder_form()),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 0, 217, 246),
        foregroundColor: Colors.white,
        onPressed: () {
          // handle the press
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Reminder_form()),
          );
        },
      ),
        body: FutureBuilder(
            future:  _reminderService.getReminders(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleReminder(reminder: snapshot.data[index]);
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
    
              // By default, show a loading spinner.
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [CircularProgressIndicator()],
                ),
              );
            }),
        bottomNavigationBar: const NavBar(
          currItem: 1,
        ),
      ),
     
    );
  }
}
