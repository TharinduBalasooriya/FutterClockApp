import 'package:clock_app/pages/alarm.dart';
import 'package:clock_app/pages/alarm_form.dart';
import 'package:clock_app/pages/reminder.dart';
import 'package:clock_app/pages/reminder_form.dart';
import 'package:clock_app/pages/notes.dart';
import 'package:clock_app/pages/world_clock.dart';
import 'package:clock_app/provider/alarm_provider.dart';
import 'package:clock_app/provider/note_provider.dart';
import 'package:clock_app/provider/reminder_provider.dart';
import 'package:clock_app/provider/worldtime_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async  => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AlarmProvider()),
            ChangeNotifierProvider(create: (context) => ReminderProvider()),
            ChangeNotifierProvider(create: (context) => WorldtimeProvider()),
            ChangeNotifierProvider(create: (context) => NoteProvider()),
          ],
          child: const MyApp(),
        ), // Wrap your app
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const WorldClock(),
      routes: {
        WorldClock.routeName: (context) => const WorldClock(),
        AlarmPage.routeName: (context) => const AlarmPage(),
        Reminder.routeName: (context) => const Reminder(),
        Notes.routeName: (context) => const Notes(),
        Reminder_form.routeName: (context) => const Reminder_form(),
        AddAlarmform.routeName: (context) => const AddAlarmform(),
        //EditAlarm.routeName: (context) => const EditAlarm(alarmId: ''),
      },
    );
  }
}
