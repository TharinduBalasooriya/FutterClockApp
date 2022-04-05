import 'package:clock_app/model/worldclock_model.dart';
import 'package:clock_app/services/world_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/worldtime_provider.dart';

class Editworld extends StatefulWidget {
  static const String routeName = '/editworld';
  final String _worldId;
  Editworld({Key? key, required String worldId})
      : _worldId = worldId,
        super(key: key);

  @override
  State<Editworld> createState() => _EditworldclockState();
}

class _EditworldclockState extends State<Editworld> {
  late String worldId;
  late WorldService _worldService;
  late final World world;
  final notecontorler = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    worldId = widget._worldId;
    _worldService = const WorldService();
    getWorlddetails();
  }

  Future<void> getWorlddetails() async {
    world = await _worldService.getWorldId(worldId);
    notecontorler.value = notecontorler.value = TextEditingValue(
      text: world.note.toString(),
    );
  

    setState(() {});
  }

  Widget _time() {
    return Column(
      children: [
        Text(
          world.time,
          style: GoogleFonts.lato(
            fontSize: 36,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          world.location,
          style: GoogleFonts.lato(
            fontSize: 46,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }

  Widget _setnote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Text(
          "Add World Note",
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        )),
        Flexible(
            child: TextFormField(
          controller: notecontorler,
          validator: (text) {
            return null;
          },
          maxLength: 60,
          decoration: const InputDecoration(hintText: "World Note"),
          onSaved: (value) {
            world.note = value!;
          },
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Country Note "),
        actions: [
          TextButton(
              onPressed: () async {
                _formKey.currentState?.save();

                World updatedworldtime =
                    await Provider.of<WorldtimeProvider>(context, listen: false)
                        .updateworld(world);
                if (updatedworldtime != null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("World Note Updated"),
                  ));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error in Updating World Note'),
                    ),
                  );
                }
              },
              child: Text("SAVE",
                  style: GoogleFonts.lato(fontSize: 17, color: Colors.white)))
        ],
      ),
      body: (SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    _setnote(),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
