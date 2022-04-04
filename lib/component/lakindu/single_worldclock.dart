import 'dart:developer';

import 'package:clock_app/model/alarm_model.dart';
import 'package:clock_app/model/worldclock_model.dart';
import 'package:clock_app/provider/alarm_provider.dart';
import 'package:clock_app/provider/worldtime_provider.dart';
import 'package:clock_app/services/world_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../services/alarm_service.dart';

class SingleWorld extends StatefulWidget {
  final World world;
  const SingleWorld({Key? key, required this.world})
      : _worldservice = const WorldService(),
        super(key: key);
  final WorldService _worldservice;

  @override
  State<SingleWorld> createState() => _SingleWorldState();
}

class _SingleWorldState extends State<SingleWorld> {
  bool _isActive = false;

  late WorldService _worldservice;
  @override
  void initState() {
    super.initState();
    _worldservice = widget._worldservice;
  }

  Future<bool> _deleteWorld() async {
    return await _worldservice.deleteWorldclock(widget.world.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorldtimeProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Slidable(
              key: const ValueKey(0),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(onDismissed: () {}),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) async {
                      bool res = await context.read<WorldtimeProvider>().deleteWorldclock(widget.world.id);
                      print(res);
                    },
                    backgroundColor: Color.fromARGB(255, 127, 12, 4),
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  const SlidableAction(
                    onPressed: null,
                    backgroundColor: Color.fromARGB(255, 230, 166, 38),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ],
              ),
              child: Material(
                child: Container(
                 margin: const EdgeInsets.all(6),
              child: ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      widget.world.location+'\n'+ widget.world.time,
                      style: GoogleFonts.lato(
                        fontSize:25,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    
                  ],
                ),
              ),
            )
                ),
              ),
            
            const Divider(),
          ],
        );
      },
    );
  }
}

