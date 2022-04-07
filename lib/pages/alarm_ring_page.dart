import 'package:clock_app/model/alarm_model.dart';
import 'package:clock_app/pages/alarm.dart';
import 'package:clock_app/services/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../provider/alarm_provider.dart';
import '../services/audio_service.dart';

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
  late Alarm alarmToBeRinged;
  bool darkThemeEnabled = false;
  late AudioService _audioService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alarmId = widget._alarmId;
    _alarmService = const AlarmService();
    getAlarmDetails();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ThemeData theme = Theme.of(context);
    darkThemeEnabled = theme.brightness == Brightness.dark;
  }

  Future<void> getAlarmDetails() async {
    alarmToBeRinged = await _alarmService.getAlarmById(alarmId);
    _audioService = AudioService();
    setState(() {
      readyToLoad = true;
      _audioService.play(alarmToBeRinged.sound);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: readyToLoad
          ? Scaffold(
              body: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 325,
                        height: 325,
                        decoration: const ShapeDecoration(
                            shape: CircleBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(255, 0, 217, 246),
                                    style: BorderStyle.solid,
                                    width: 4))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const Icon(
                              Icons.alarm,
                              color: Color.fromARGB(255, 0, 217, 246),
                              size: 32,
                            ),
                            Text(
                                alarmToBeRinged.minute < 10
                                    ? alarmToBeRinged.hour.toString() +
                                        ":" +
                                        "0" +
                                        alarmToBeRinged.minute.toString()
                                    : alarmToBeRinged.hour.toString() +
                                        " : " +
                                        alarmToBeRinged.minute.toString() +
                                        "  " +
                                        alarmToBeRinged.ampm,
                                style: GoogleFonts.lato(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w700,
                                )),
                            Text(
                              "Wake Up !!!",
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SlideAction(
                        height: 80,
                        sliderButtonIcon: const Icon(
                          Icons.chevron_right,
                          size: 36,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Turn off alarm!',
                            style: GoogleFonts.lato(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromARGB(255, 85, 85, 85)),
                          ),
                        ),
                        onSubmit: () async {
                          alarmToBeRinged.active = false;
                          Alarm updatedAlarm = await Provider.of<AlarmProvider>(
                                  context,
                                  listen: false)
                              .updateAlarm(alarmToBeRinged);
                          _audioService.stop();
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const AlarmPage()));
                          
                        },
                        innerColor: const Color.fromARGB(255, 85, 85, 85),
                        outerColor: const Color.fromARGB(255, 0, 217, 246),
                      ),
                    )
                  ],
                ),
              ),
            )
          : const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
