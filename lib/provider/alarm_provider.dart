import 'package:flutter/material.dart';
import '../model/alarm_model.dart';
import '../services/alarm_service.dart';

class AlarmProvider extends ChangeNotifier {
  late AlarmService _alarmService;
  List<Alarm> _alarms = [];
  AlarmProvider() {
    _alarmService = AlarmService();
  }

  Future<List<Alarm>> getAlarms() async {
    _alarms = await _alarmService.getAlarms();
    notifyListeners();
    return _alarms;
  }

  Future<bool> deleteAlarm(String id) async {
    bool result = await _alarmService.deleteAlarm(id);
    notifyListeners();
    return result;
  }

  Future<Alarm> addAlarm(Alarm alarm) async {
   
     Alarm result =  await _alarmService.createAlarm(alarm);
    notifyListeners();
    return result;
  }

  Future<Alarm> updateAlarm(Alarm alarm) async {
    Alarm result = await _alarmService.updateAlarm(alarm);
    notifyListeners();
    return result;
  }

}
