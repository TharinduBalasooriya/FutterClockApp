// class Alarm {
//   final int id;
//   final int hour;
//   final int minute;
//   final String ampm;
//   final String[] days;

//   const Alarm({required this.id, required this. hour, required this.minute, required this.ampm, required this.days});
// }


class Alarm {
  final String id;
  final int hour;
  final int minute;
  final String ampm;
  final dynamic days;
  final String sound;


  const Alarm({required this.id, required this. hour, required this.minute, required this.ampm,required this.days, required this.sound});

  factory Alarm.fromJSON(Map<String, dynamic> data) {
    return Alarm(
      id: data['_id'],
      hour: data['hour'],
      minute: data['minute'],
      ampm: data['ampm'],
      days: data['days'],
      sound: data['sound'],
    );
  }
}
