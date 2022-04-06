// class Alarm {
//   final int id;
//   final int hour;
//   final int minute;
//   final String ampm;
//   final String[] days;

//   const Alarm({required this.id, required this. hour, required this.minute, required this.ampm, required this.days});
// }

class Alarm {
  String id;
  int hour;
  int minute;
  String ampm;
  List<dynamic> days;
  String sound;
  bool active;

  Alarm(
      {required this.id,
      required this.hour,
      required this.minute,
      required this.ampm,
      required this.active,
      required this.days,
      required this.sound});

  factory Alarm.fromJSON(Map<String, dynamic> data) {
    return Alarm(
      id: data['_id'],
      hour: data['hour'],
      minute: data['minute'],
      ampm: data['ampm'],
      active: data['active'],
      days: data['days'],
      sound: data['sound'],
    );
  }
}
