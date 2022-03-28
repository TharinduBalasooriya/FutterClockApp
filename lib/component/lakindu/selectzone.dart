import 'package:flutter/material.dart';
import 'package:clock_app/component/lakindu/services/worldtimeapi.dart';

class Selectzone extends StatefulWidget{
  @override
  _SelectzoneState createState() => _SelectzoneState();
}

class _SelectzoneState extends State<Selectzone> {
 List<WorldTime> locations = [
    WorldTime(
        timezone: 'Asia/Dhaka', location: 'Dhaka', flag: 'bangladesh.png'),
    WorldTime(timezone: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(timezone: 'Europe/Athens', location: 'Athens', flag: 'greece.png'),
    WorldTime(timezone: 'Europe/Berlin', location: 'Berlin', flag: 'germany.png'),
    WorldTime(timezone: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(timezone: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(timezone: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(timezone: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(timezone: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(timezone: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png')
  ];

  void updateTime(index) async {
    WorldTime worldTimeObj = locations[index];
    await worldTimeObj.getTime();

    Navigator.pop(context, {
      'location': worldTimeObj.location,
      'flag': worldTimeObj.flag,
      'time': worldTimeObj.time,
      'isDayTime': worldTimeObj.isDayTime,
    });
    print(worldTimeObj.location);
    print(worldTimeObj.time);

  }



  @override
  Widget build(BuildContext context) {
  return Scaffold(
        backgroundColor: Color.fromARGB(255, 43, 43, 43),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 30, 31, 31),
          title: Text('Choose a Location'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 1, 5, 0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(
                    locations[index].location,
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.1
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        '/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          },
        )
    );

  }
}