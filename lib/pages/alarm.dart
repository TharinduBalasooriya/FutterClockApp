import 'package:clock_app/pages/alarm_form.dart';
import 'package:clock_app/pages/world_clock.dart';
import 'package:clock_app/provider/alarm_provider.dart';
import 'package:clock_app/services/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../component/alarm_component/single_alarm_component.dart';
import '../component/navBar.dart';

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
  @override
  void initState() {
    super.initState();
    _alarmService = widget._alarmService;
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
