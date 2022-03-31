import 'dart:convert';
import 'dart:developer';

import 'package:clock_app/model/alarm_model.dart';
import 'package:http/http.dart' as http;

class AlarmService {
  const AlarmService();

  Future<List<Alarm>> getAlarms() async {
    var url = Uri.parse('https://clock-app-ctse.herokuapp.com/api/alarms');
    late http.Response response;
    List<Alarm> alarms = [];

    try {
      response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> alarmData = jsonDecode(response.body);

        for (var item in alarmData) {
          alarms.add(Alarm.fromJSON(item));
        }
      } else {
        return Future.error("Something gone wrong, ${response.statusCode}");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return alarms;
  }

//Create Alarm
  Future<Alarm> createAlarm(Alarm alarm) async {
    final response = await http.post(
      Uri.parse('https://clock-app-ctse.herokuapp.com/api/alarms'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "hour": alarm.hour,
        "minute": alarm.minute,
        "ampm": alarm.ampm,
        "days": alarm.days,
        "active": true,
        "sound": alarm.sound
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Alarm.fromJSON(json.decode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}