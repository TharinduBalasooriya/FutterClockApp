import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String timezone;
  late bool isDayTime;
  late DateTime now;

  WorldTime({required this.location, required this.flag, required this.timezone});

  Future<void> getTime() async {

    try{
      Response response =
      await get(Uri.parse('http://worldtimeapi.org/api/timezone/$timezone'));
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      

      // create a date time obj
      now  = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));
      // print('Now: $now');

      isDayTime = now.hour > 6 && now.hour < 20 ? true: false;
      // print('Is day time: $isDayTime');

      time = DateFormat.jm().format(now);
      // print('Time: $time');
    }
    catch(e){
      print('Error: $e');
      time = 'Could not get the time data';
    }
  }
}
