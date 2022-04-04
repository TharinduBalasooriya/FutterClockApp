import 'dart:async';
import 'package:clock_app/component/lakindu/clockview.dart';
import 'package:clock_app/component/lakindu/selectzone.dart';
import 'package:clock_app/component/lakindu/worldlist.dart';
import 'package:clock_app/services/world_service.dart';
import 'package:flutter/material.dart';
import '../component/navBar.dart';
import 'package:intl/intl.dart';

class WorldClock extends StatefulWidget {
  static const String routeName = '/worldclock';
  final WorldService _worldService;
  const WorldClock({Key? key}) 
  : _worldService = const WorldService(),
    super(key:key);


  @override
  State<WorldClock> createState() => _WorldClockState();
}

class _WorldClockState extends State<WorldClock> {
  late WorldService _worldService;
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedDate = DateFormat('EEE,d MMM').format(now);
    return Scaffold(
      appBar: AppBar(
        title: const Text("WorldClock"),
      ),
      body: Column(

        children: [
          Row(
            children: [
              Container(
                child: Container(child: Clockview()),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const DigitalClockWidget(),
                    Text(
                      formattedDate,
                      style: const TextStyle(
                          fontFamily: 'avenir',
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                color: Colors.cyan,
                shape: CircleBorder(),
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Selectzone()),
                  );
                },
              ),
            ),]
          ),
          const SizedBox(height:260,
        child:WorldClocklists()),
        ],
      
      ),
      bottomNavigationBar: const NavBar(currItem: 0),
    );
  }
}

class DigitalClockWidget extends StatefulWidget {
  const DigitalClockWidget({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DigitalClockWidgetState();
  }
}

class DigitalClockWidgetState extends State<DigitalClockWidget> {
  var formattedTime = DateFormat('hh mm').format(DateTime.now());
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var perviousMinute =
          DateTime.now().add(const Duration(seconds: -1)).minute;
      var currentMinute = DateTime.now().minute;
      if (perviousMinute != currentMinute) {
        setState(() {
          formattedTime = DateFormat('hh mm').format(DateTime.now());
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedTime,
      style: const TextStyle(
          fontFamily: 'avenir', color: Colors.grey, fontSize: 68),
    );
  }
}
