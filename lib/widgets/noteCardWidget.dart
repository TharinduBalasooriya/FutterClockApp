import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/note_model.dart';
import '../pages/notePage.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: () {
            print("Click event on Container");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotePage()),
            );
          },
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
            margin: const EdgeInsets.only(
              bottom: 20.0,
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.note.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
