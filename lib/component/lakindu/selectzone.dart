import 'package:clock_app/model/worldclock_model.dart';
import 'package:clock_app/pages/world_clock.dart';
import 'package:clock_app/provider/worldtime_provider.dart';
import 'package:clock_app/services/world_service.dart';
import 'package:flutter/material.dart';
import 'package:clock_app/component/lakindu/services/worldtimeapi.dart';
import 'package:provider/provider.dart';

class Selectzone extends StatefulWidget {
  static const String routeName = '/addworld';
  final WorldService _worldService;
  const Selectzone({Key? key})
      : _worldService = const WorldService(),
        super(key: key);

  @override
  _SelectzoneState createState() => _SelectzoneState();
}

class _SelectzoneState extends State<Selectzone> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late WorldService _worldService;
  @override
  void initState() {
    super.initState();
    _worldService = widget._worldService;
  }

  List<WorldTime> locations = [
    WorldTime(
        timezone: 'Asia/Dhaka', location: 'Bangladesh', flag: 'bangladesh.png'),
    WorldTime(timezone: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(
        timezone: 'Europe/Athens', location: 'Greece', flag: 'greece.png'),
    WorldTime(
        timezone: 'Europe/Berlin', location: 'Germany', flag: 'germany.png'),
    WorldTime(timezone: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(
        timezone: 'Africa/Nairobi', location: 'Kenya', flag: 'kenya.png'),
    WorldTime(
        timezone: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(
        timezone: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(
        timezone: 'Asia/Seoul', location: 'South Korea', flag: 'south_korea.png'),
    WorldTime(
        timezone: 'Asia/Jakarta', location: 'Indonesia', flag: 'indonesia.png'),
    WorldTime(
        timezone: 'Asia/Kathmandu', location: 'Nepal', flag: 'nepal.png'),
    WorldTime(
        timezone: 'Asia/Kolkata', location: 'India', flag: 'india.png'),
    WorldTime(
        timezone: 'Asia/Hong_Kong', location: 'China', flag: 'china.png'),
    WorldTime(
        timezone: 'Asia/Kabul', location: 'Afganistan ', flag: 'af.png'),    
    WorldTime(
        timezone: 'Asia/Singapore', location: 'Singapore', flag: 'singapoor.png'),
    WorldTime(
        timezone: 'Asia/Tokyo', location: 'Japan', flag: 'japan.png'), 
    WorldTime(
        timezone: 'Australia/Sydneye', location: 'Australia', flag: 'australia.png'), 

    WorldTime(
        timezone: 'Pacific/Auckland', location: 'New Zealand', flag: 'newzeland.png'),
      
    WorldTime(
        timezone: 'Europe/Moscow', location: 'Rusia', flag: 'rusia.png'),
        
  ];

  void updateTime(index) async {
    WorldTime worldTimeObj = locations[index];
    await worldTimeObj.getTime();

    print(worldTimeObj.location);
    print(worldTimeObj.time);
    World world =
        World(location: worldTimeObj.location, time: worldTimeObj.time, id: "",note: '');
         World createworldtime = await Provider.of<WorldtimeProvider>(context,listen:false).createWorldtime(world);
    if (createworldtime != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('World Clock Added Successfully')),
      );
      Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) =>  WorldClock()),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error In Adding World Clock'),
        ),
      );
    }
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
                    style: TextStyle(fontSize: 18, letterSpacing: 1.1),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
