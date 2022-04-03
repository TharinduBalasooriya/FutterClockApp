import 'package:clock_app/pages/alarm.dart';
import 'package:clock_app/pages/alarm_form.dart';
import 'package:clock_app/pages/reminder.dart';
import 'package:clock_app/pages/reminder_form.dart';
import 'package:clock_app/pages/todo.dart';
import 'package:clock_app/pages/world_clock.dart';
import 'package:clock_app/provider/alarm_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AlarmProvider()),
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
        ToDoList.routeName: (context) => const ToDoList(),
        Reminder_form.routeName: (context) => const Reminder_form(),
        AddAlarmform.routeName: (context) => const AddAlarmform(),
      },
    );
  }
}
