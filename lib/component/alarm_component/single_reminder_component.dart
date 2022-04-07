import 'dart:async';
import 'dart:developer';

import 'package:clock_app/provider/reminder_provider.dart';
import 'package:clock_app/services/reminder_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../pages/edit_reminder.dart';
import '../../model/reminder_model.dart';
import 'package:intl/intl.dart';

class SingleReminder extends StatefulWidget {
  final Reminder reminder;
  const SingleReminder({Key? key, required this.reminder})
      : _reminderService = const ReminderService(),
        super(key: key);
  final ReminderService _reminderService;

  @override
  State<SingleReminder> createState() => _SingleRemindertate();
}

class _SingleRemindertate extends State<SingleReminder> {
  bool _isActive = false;
  var timer;

  late ReminderService _reminderService;
  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(Duration(seconds: 4), (Timer t) => checkActiveAlarm());
    _reminderService = widget._reminderService;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<bool> _deleteReminder() async {
    return await _reminderService.deleteReminder(widget.reminder.id);
  }

  void checkActiveAlarm() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
//  print(widget.reminder.date);
//     print("----------------");
//      print(formattedDate.toString());
    if (widget.reminder.date == formattedDate.toString()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          child: Row(
            children: [
              const Icon(Icons.notification_add_rounded),
              Text(
                "   REMINDERS\n" +
                    "   " +
                    widget.reminder.name +
                    "   " +
                    widget.reminder.priority,
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 217, 246),
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 500.0),
        action: SnackBarAction(
          label: 'Dismiss',
          disabledTextColor: Colors.white,
          textColor: Colors.deepOrange,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReminderProvider>(
      builder: (context, provider, child) {
        return Container(
          child: Column(
            children: [
              Slidable(
                key: const ValueKey(0),
                // The start action pane is the one at the left or the top side.
                startActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),

                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(onDismissed: () {}),

                  // All actions are defined in the children parameter.
                  children: [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      onPressed: (BuildContext context) async {
                        //context.read<MyData>().changeName(Random().nextInt(100).toString());
                        bool res = await context
                            .read<ReminderProvider>()
                            .deleteReminder(widget.reminder.id);
                        print(res);
                        if (res) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Alarm deleted"),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Alarm delete failed"),
                          ));
                        }
                      },

                      backgroundColor: Color.fromARGB(255, 139, 9, 0),
                      //foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (BuildContext context) async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditReminder(reminderId: widget.reminder.id)),
                        );
                      },
                      backgroundColor: const Color.fromARGB(255, 119, 193, 227),
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                ),
                child: Material(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // radius of 10
                        color: const Color.fromARGB(
                            255, 73, 73, 73) // green as background color
                        ),
                    margin: const EdgeInsets.all(6),
                    child: ListTile(
                      // leading: const Icon(
                      //   Icons.calendar_month,
                      // ),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            widget.reminder.priority + "  ",
                            style: GoogleFonts.lato(
                              fontSize: 30,
                              color: Color.fromARGB(255, 211, 83, 83),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            widget.reminder.name,
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(
                            "",
                            style: GoogleFonts.lato(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Container(
                        child: Text(
                          widget.reminder.date +
                              "                         " +
                              widget.reminder.repeat +
                              "\n" +
                              widget.reminder.note,
                          style: GoogleFonts.roboto(fontSize: 15),
                        ),
                        margin: const EdgeInsets.only(top: 2.0),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
