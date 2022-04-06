import 'package:clock_app/model/alarm_model.dart';
import 'package:clock_app/services/alarm_service.dart';
import 'package:flutter/material.dart';

class AlarmRing extends StatefulWidget {
  static const String routeName = '/ringAlarm';
  final String _alarmId;
  const AlarmRing({Key? key, required String alarmId})
      : _alarmId = alarmId,
        super(key: key);

  @override
  State<AlarmRing> createState() => _AlarmRingState();
}

class _AlarmRingState extends State<AlarmRing> {
  bool readyToLoad = false;
  late String alarmId;
  late AlarmService _alarmService;
  late Alarm alarm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alarmId = widget._alarmId;
    _alarmService = const AlarmService();
    getAlarmDetails();
  }

  Future<void> getAlarmDetails() async {
    alarm = await _alarmService.getAlarmById(alarmId);
    setState(() {
      readyToLoad = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: readyToLoad
          ? Text(alarm.hour.toString())
          : const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
