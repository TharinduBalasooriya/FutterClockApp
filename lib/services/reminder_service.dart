import 'dart:convert';
import 'dart:developer';

import 'package:clock_app/model/reminder_model.dart';
import 'package:http/http.dart' as http;

class ReminderService {
  const ReminderService();

  Future<List<Reminder>> getReminders() async {
    var url = Uri.parse('https://clock-app-ctse.herokuapp.com/api/reminders');
    late http.Response response;
    List<Reminder> alarms = [];

    try {
      response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> alarmData = jsonDecode(response.body);

        for (var item in alarmData) {
          alarms.add(Reminder.fromJSON(item));
        }
      } else {
        return Future.error("Something gone wrong, ${response.statusCode}");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return alarms;
  }

//Create Reminder
  Future<Reminder> createReminder(Reminder reminder) async {
    final response = await http.post(
      Uri.parse('https://clock-app-ctse.herokuapp.com/api/reminders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "name": reminder.name,
        "date": reminder.date,
        "time": reminder.time,
        "repeat": reminder.repeat,
        "priority": reminder.priority,
        "note": reminder.note,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Reminder.fromJSON(json.decode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Reminder.');
    }
  }


  //Delete Reminder
  Future<bool> deleteReminder(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://clock-app-ctse.herokuapp.com/api/reminders/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete Reminder.');
    }
  }

   //Get reminder by id
  Future<Reminder> getReminderById(String id) async {
    final response = await http.get(
      Uri.parse('https://clock-app-ctse.herokuapp.com/api/reminders/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Reminder.fromJSON(json.decode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to get Reminder');
    }
  }

//Update Reminder
  Future<Reminder> updateReminder(Reminder reminder) async {
    final response = await http.put(
      Uri.parse(
          'https://clock-app-ctse.herokuapp.com/api/reminders/${reminder.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "name": reminder.name,
        "date": reminder.date,
        "time": reminder.time,
        "repeat": reminder.repeat,
        "priority": reminder.priority,
        "note": reminder.note,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Reminder.fromJSON(json.decode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update Reminder.');
    }
  }
}
