import 'package:clock_app/model/note_model.dart';
import 'package:clock_app/pages/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../component/navBar.dart';
import '../provider/note_provider.dart';
import '../services/note_service.dart';

class NewNote extends StatefulWidget {
  static const String routeName = '/newNote';
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
  Color _noteColor = Color(0xff9e9e9e);
  String _hexColor = "";
  int _red = 0;
  int _green = 0;
  int _blue = 0;
  // DateTime _createdDate = DateTime.now();

  int _getColorFromHex(String hexColor) {
    return int.parse(hexColor, radix: 16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
        actions: <Widget>[
          TextButton(
              onPressed: () async {
                _formKey.currentState?.save();

                String hexColor = _noteColor.value.toRadixString(16);
                int intColor = _getColorFromHex(hexColor);

                print(hexColor);

                Note note = Note(
                    id: "",
                    title: _title,
                    description: _description,
                    red: _noteColor.red,
                    green: _noteColor.green,
                    blue: _noteColor.blue,
                    noteColor: _hexColor,
                    createdDate: DateFormat('yyyy-MM-dd – kk:mm')
                        .format(DateTime.now()));
                Note createdNote =
                    await Provider.of<NoteProvider>(context, listen: false)
                        .addNote(note);

                if (createdNote != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Note created successfully'),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notes()),
                  );
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
                    _title = value!;
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
                        _description = value!;
                      }),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 54, 54, 54)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Pick a color!'),
                          content: SingleChildScrollView(
                              child: BlockPicker(
                            pickerColor: _noteColor, //default color
                            onColorChanged: (Color color) async {
                              //on color picked
                              setState(
                                () {
                                  _noteColor = color;
                                },
                              );
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
