import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../component/navBar.dart';
import '../model/note_model.dart';
import '../provider/note_provider.dart';
import '../services/note_service.dart';

class EditNote extends StatefulWidget {
  static const String routeName = '/editNote';
  final String _noteId;
  const EditNote({Key? key, required String noteId})
      : _noteId = noteId,
        super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  bool readyToLoad = false;
  late String noteId;
  late NoteService _noteService;
  late Note note;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Color _noteColor = Color(0xff9e9e9e);

  @override
  void initState() {
    super.initState();
    noteId = widget._noteId;
    _noteService = const NoteService();
    getNoteDetails();
  }

  Future<void> getNoteDetails() async {
    note = await _noteService.getNoteById(noteId);
    titleController.value = TextEditingValue(
      text: note.title.toString(),
      selection: TextSelection.fromPosition(
        TextPosition(offset: note.title.toString().length),
      ),
    );
    descriptionController.value = TextEditingValue(
      text: note.description.toString(),
      selection: TextSelection.fromPosition(
        TextPosition(offset: note.description.toString().length),
      ),
    );

    setState(() {
      readyToLoad = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Note"), actions: [
        TextButton(
            onPressed: () async {
              _formKey.currentState?.save();

              String title = "";
              String description = "";

              note.title = title;
              note.description = description;

              Note updatedNote =
                  await Provider.of<NoteProvider>(context, listen: false)
                      .updateNote(note);

              if (updatedNote != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Note updated successfully'),
                  ),
                );
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error updating note'),
                  ),
                );
              }
            },
            child: Text("SAVE",
                style: GoogleFonts.lato(fontSize: 17, color: Colors.white)))
      ]),
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(
              top: 30.0, right: 25.0, left: 25.0, bottom: 250.0),
          decoration: BoxDecoration(
            // color: Color.fromARGB(255, 214, 213, 213),
            color: Color(_noteColor.value),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
              child: Column(
            children: [
              TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      hintText: "Enter Note Title",
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 25.0)),
                  style: const TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  onSaved: (value) {
                    note.title = value!;
                  }),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      minLines: 10,
                      maxLines: 15,
                      decoration: const InputDecoration(
                          hintText: "Enter Description",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 24.0)),
                      onSaved: (value) {
                        note.description = value!;
                      }),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 199, 198, 198)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Pick a color!'),
                          content: SingleChildScrollView(
                              child: BlockPicker(
                            pickerColor: _noteColor, //default color
                            onColorChanged: (Color color) {
                              //on color picked
                              setState(() {
                                note.noteColor = color.value.toString();
                              });
                            },
                          )),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('DONE'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); //dismiss the color picker
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Text("Select Color"),
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
