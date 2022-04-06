import 'package:clock_app/model/note_model.dart';
import 'package:clock_app/pages/todo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../component/navBar.dart';
import '../provider/note_provider.dart';
import '../services/note_service.dart';

class NewNote extends StatefulWidget {
  static const String routeName = '/note';
  const NewNote({Key? key}) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  NoteService remindeservice = NoteService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String _title = '';
  String _description = '';
  // DateTime _createdDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
        actions: <Widget>[
          TextButton(
              onPressed: () async {
                _formKey.currentState?.save();

                Note note = Note(
                  id: "",
                  title: _title,
                  description: _description,
                  // createdDate: DateTime.now()
                );

                print(note.title);
                print(note.description);
                print(DateTime.now());
                Note createdNote =
                    await Provider.of<NoteProvider>(context, listen: false)
                        .addNote(note);

                if (createdNote != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Note created successfully'),
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error creating Note'),
                    ),
                  );
                }
              },
              child: Text("SAVE",
                  style: GoogleFonts.lato(fontSize: 17, color: Colors.white)))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: Center(
              child: Column(
            children: [
              TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      hintText: "Enter Note Title",
                      contentPadding: EdgeInsets.symmetric(horizontal: 24.0)),
                  style: const TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black12),
                  onSaved: (value) {
                    _title = value!;
                  }),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 6,
                      decoration: const InputDecoration(
                          hintText: "Enter Description",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 24.0)),
                      onSaved: (value) {
                        _description = value!;
                      }),
                ),
              ),
            ],
          )),
        ),
      ),
      bottomNavigationBar: const NavBar(
        currItem: 2,
      ),
    );
  }
}
