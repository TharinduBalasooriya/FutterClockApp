class Reminder{
  final String id;
  final String name;
  final String date;
  final String time;
  final String repeat;
  final String priority;
  final String note;


  const Reminder({required this.id, required this.name, required this.date, required this.time, required this.repeat,required this.priority, required this.note});

  factory Reminder.fromJSON(Map<String, dynamic> data) {
    return Reminder(
      id: data['_id'],
      name: data['name'],
      date: data['date'],
      time: data['time'],
      repeat: data['repeat'],
      priority: data['priority'],
      note: data['note'],
    );
  }
}
