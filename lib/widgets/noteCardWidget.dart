import 'package:clock_app/pages/editnote.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/note_model.dart';
import '../pages/notePage.dart';
import '../pages/notes.dart';
import '../provider/note_provider.dart';
import '../services/note_service.dart';

class NoteCardWidget extends StatefulWidget {
  final Note note;
  const NoteCardWidget({Key? key, required this.note})
      : _noteService = const NoteService(),
        super(key: key);
  final NoteService _noteService;
  // final String title;
  // final String description;

  @override
  State<NoteCardWidget> createState() => _NoteCardWidgetState();
}

class _NoteCardWidgetState extends State<NoteCardWidget> {
  late NoteService _noteService;
  @override
  void initState() {
    super.initState();
    _noteService = widget._noteService;
  }

  // set up the AlertDialog

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm Delete"),
      content: Text("Are you sure you want to delete the note " +
          widget.note.title +
          "?"),
      actions: <Widget>[
        TextButton(
            onPressed: () async {
              var res = await _noteService.deleteNote(widget.note.id);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notes()),
              );
            },
            child: Text("Yes, Delete",
                style: GoogleFonts.lato(
                    fontSize: 17,
                    color: Colors.red,
                    fontWeight: FontWeight.bold))),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("No",
                style: GoogleFonts.lato(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold))),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  // showAlertDialog(BuildContext context) {

  //   return alert;
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditNote(noteId: widget.note.id)),
            );
          },
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 25.0, horizontal: 24.0),
            margin: const EdgeInsets.only(
              bottom: 20.0,
            ),
            decoration: BoxDecoration(
                color: Color.fromARGB(
                    255, widget.note.red, widget.note.green, widget.note.blue),
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Text(
                      widget.note.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        icon: const Icon(Icons.delete, color: Colors.white)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    widget.note.description,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Text("Created Date - " + widget.note.createdDate),
              ],
            ),
          ),
        );
      },
    );
  }
}
