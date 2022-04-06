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

  //Delete Alarm
  Future<bool> deleteAlarm(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://clock-app-ctse.herokuapp.com/api/alarms/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete album.');
    }
  }

  //Get alarm by id
  Future<Alarm> getAlarmById(String id) async {
    final response = await http.get(
      Uri.parse('https://clock-app-ctse.herokuapp.com/api/alarms/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Alarm.fromJSON(json.decode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to get Alaem');
    }
  }

  //Update Alarm
  Future<Alarm> updateAlarm(Alarm alarm) async {
    final response = await http.put(
      Uri.parse('https://clock-app-ctse.herokuapp.com/api/alarms/${alarm.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "hour": alarm.hour,
        "minute": alarm.minute,
        "ampm": alarm.ampm,
        "days": alarm.days,
        "active": alarm.active,
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
      throw Exception('Failed to update Alarm.');
    }
  }
}
