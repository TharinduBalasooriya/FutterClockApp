import 'package:flutter/material.dart';
import '../model/reminder_model.dart';
import '../services/reminder_service.dart';

class ReminderProvider extends ChangeNotifier {
  late ReminderService _reminderService;
  List<Reminder> __reminders = [];
  ReminderProvider() {
    _reminderService = ReminderService();
  }

  Future<List<Reminder>> getReminder() async {
    __reminders = await _reminderService.getReminders();
    notifyListeners();
    return __reminders;
  }

  Future<bool> deleteReminder(String id) async {
    bool result = await _reminderService.deleteReminder(id);

    notifyListeners();
    return result;
  }

  Future<Reminder> addReminder(Reminder reminder) async {
    Reminder result = await _reminderService.createReminder(reminder);
    notifyListeners();
    return result;
  }

  Future<Reminder> updateReminder(Reminder reminder) async {
    Reminder result = await _reminderService.updateReminder(reminder);
    notifyListeners();
    return result;
  }
}
