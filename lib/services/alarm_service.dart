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
}
