import 'dart:convert';

import 'package:clock_app/model/note_model.dart';
import 'package:http/http.dart' as http;

class NoteService {
  const NoteService();

  Future<List<Note>> getNotes() async {
    var url = Uri.parse('https://clock-app-ctse.herokuapp.com/api/notes');
    late http.Response response;
    List<Note> notes = [];

    try {
      response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> noteData = jsonDecode(response.body);

        for (var item in noteData) {
          notes.add(Note.fromJSON(item));
        }
      } else {
        return Future.error("Something gone wrong, ${response.statusCode}");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return notes;
  }

//Create Note
  Future<Note> createNote(Note note) async {
    final response = await http.post(
      Uri.parse('https://clock-app-ctse.herokuapp.com/api/notes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "title": note.title,
        "description": note.description,
        "createdDate": note.createdDate,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Note.fromJSON(json.decode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Note.');
    }
  }

  //Delete Note
  Future<bool> deleteNote(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://clock-app-ctse.herokuapp.com/api/notes/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete Note.');
    }
  }

  //Get note by id
  Future<Note> getNoteById(String id) async {
    final response = await http.get(
      Uri.parse('https://clock-app-ctse.herokuapp.com/api/notes/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Note.fromJSON(json.decode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to get Note');
    }
  }

  //Update Note
  Future<Note> updateNote(Note note) async {
    final response = await http.put(
      Uri.parse('https://clock-app-ctse.herokuapp.com/api/notes/${note.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "title": note.title,
        "descripton": note.description
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Note.fromJSON(json.decode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update Note.');
    }
  }
}
