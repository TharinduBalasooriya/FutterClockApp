import 'dart:async';

import 'package:clock_app/pages/alarm_form.dart';
import 'package:clock_app/pages/alarm_ring_page.dart';
import 'package:clock_app/provider/alarm_provider.dart';
import 'package:clock_app/services/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../component/alarm_component/single_alarm_component.dart';
import '../component/navBar.dart';
import '../model/alarm_model.dart';
import 'package:intl/intl.dart';

class AlarmPage extends StatefulWidget {
  static const String routeName = '/alarm';
  final AlarmService _alarmService;
  const AlarmPage({Key? key})
      : _alarmService = const AlarmService(),
        super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmState();
}

class _AlarmState extends State<AlarmPage> {
  late AlarmService _alarmService;
  late List<Alarm> _alarms;

  @override
  void initState() {
    super.initState();
    _alarmService = widget._alarmService;
    checkActiveAlarm();
  }

  void checkActiveAlarm() async {
    const oneSec = Duration(seconds: 3);
    Timer.periodic(oneSec, (Timer t) async {
      _alarms = await _alarmService.getAlarms();
      String hour = DateFormat('h').format(DateTime.now());
      String minute = DateFormat('m').format(DateTime.now());
      String ampm = DateFormat('a').format(DateTime.now());

      _alarms.forEach((Alarm element) {
        if (element.hour.toString() == hour &&
            element.minute.toString() == minute &&
            element.ampm.toString() == ampm) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AlarmRing(alarmId: element.id)));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Alarm"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // handle the press
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddAlarmform()),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder(
            future: _alarmService.getAlarms(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleAlarm(alarm: snapshot.data[index]);
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error ${snapshot.error}');
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
