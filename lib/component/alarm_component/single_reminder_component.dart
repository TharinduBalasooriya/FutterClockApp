import 'dart:developer';


import 'package:clock_app/provider/reminder_provider.dart';
import 'package:clock_app/services/reminder_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../model/reminder_model.dart';


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

  late ReminderService _reminderService;
  @override
  void initState() {
    super.initState();
    _reminderService = widget._reminderService;
  }

  Future<bool> _deleteReminder() async {
    return await _reminderService.deleteReminder(widget.reminder.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReminderProvider>(
      builder: (context, provider, child) {
        return Column(
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
                      bool res = await context.read<ReminderProvider>().deleteReminder(widget.reminder.id);
                      print(res);
                      if (res) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Alarm deleted"),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Alarm delete failed"),
                        ));
                      }
                    },

                    backgroundColor: Color.fromARGB(255, 210, 14, 0),
                    //foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  const SlidableAction(
                    onPressed: null,
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ],
              ),
              child: Material(
                child: Container(
                  margin: const EdgeInsets.all(6),
                  child: ListTile(
                    leading: const Icon(
                      Icons.calendar_month,
                    ),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                         Text(
                          widget.reminder.priority+"  ",
                          style: GoogleFonts.lato(
                            fontSize: 30,
                            color: Color.fromARGB(255, 211, 83, 83),
                          
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          widget.reminder.name ,
                            
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
                        widget.reminder.date + "  "+widget.reminder.repeat+ "\n" +widget.reminder.note,
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
        );
      },
    );
  }
}

