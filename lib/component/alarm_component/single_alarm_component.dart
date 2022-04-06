import 'dart:developer';

import 'package:clock_app/model/alarm_model.dart';
import 'package:clock_app/provider/alarm_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../pages/edit_alarm.dart';
import '../../services/alarm_service.dart';

class SingleAlarm extends StatefulWidget {
  final Alarm alarm;
  const SingleAlarm({Key? key, required this.alarm})
      : _alarmService = const AlarmService(),
        super(key: key);
  final AlarmService _alarmService;

  @override
  State<SingleAlarm> createState() => _SingleAlarmState();
}

class _SingleAlarmState extends State<SingleAlarm> {
  bool _isActive = false;

  late AlarmService _alarmService;
  @override
  void initState() {
    super.initState();
    _alarmService = widget._alarmService;
  }

  Future<bool> _deleteAlarm() async {
    return await _alarmService.deleteAlarm(widget.alarm.id);
  }

  Future<void> _updateAlarm(Alarm alarm) async {
    await _alarmService.updateAlarm(alarm);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmProvider>(
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
                      bool res = await context
                          .read<AlarmProvider>()
                          .deleteAlarm(widget.alarm.id);
                      print(res);
                    },

                    backgroundColor: Color.fromARGB(255, 210, 14, 0),
                    //foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (BuildContext context) async {

                      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditAlarm(alarmId:widget.alarm.id)),
                );
                    },
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
                  child: SwitchListTile(
                    activeTrackColor: Color.fromARGB(255, 103, 237, 255),
                    activeColor: Color.fromARGB(255, 0, 217, 246),
                    secondary: const Icon(
                      Icons.alarm,
                    ),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text( widget.alarm.minute < 10 ? widget.alarm.hour.toString() + ":" + "0" + widget.alarm.minute.toString() : widget.alarm.hour.toString() + ":" + widget.alarm.minute.toString(),
                          style: GoogleFonts.lato(
                            fontSize: 48,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          widget.alarm.ampm,
                          style: GoogleFonts.lato(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Container(
                      child: Text(
                        widget.alarm.days.join(", "),
                        style: GoogleFonts.roboto(fontSize: 15),
                      ),
                      margin: const EdgeInsets.only(top: 2.0),
                    ),
                    value: widget.alarm.active,
                    onChanged: (bool value)  {
                      log("test1");
                      widget.alarm.active = value;
                      _updateAlarm(widget.alarm);
     
                    },
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
