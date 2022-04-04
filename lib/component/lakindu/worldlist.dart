import 'package:clock_app/component/lakindu/single_worldclock.dart';
import 'package:clock_app/provider/worldtime_provider.dart';
import 'package:clock_app/services/world_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class WorldClocklists  extends StatefulWidget {
  static const String routeName = '/worldclockaa';
  final WorldService _worldService;
  const WorldClocklists ({Key? key})
      : _worldService = const WorldService(),
        super(key: key);

  @override
  State<WorldClocklists> createState() => _WorldClockState();
}

class _WorldClockState extends State<WorldClocklists> {
  late WorldService _worldService;
  @override
  void initState() {
    super.initState();
    _worldService = widget._worldService;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorldtimeProvider>(
      builder: (context, value, child) => Scaffold
      (body: 
        FutureBuilder(
          future: _worldService.getWorld(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return 
                  (
                    SingleWorld(world: snapshot.data[index])                 
                  );
                  

                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [CircularProgressIndicator()],
              ),
            );
          }),
       )

     
    );
  }
}
