import 'package:flutter/material.dart';
import '../model/note_model.dart';
import '../services/note_service.dart';

class NoteProvider extends ChangeNotifier {
  late NoteService _noteService;
  List<Note> __notes = [];
  NoteProvider() {
    _noteService = NoteService();
  }

  Future<List<Note>> getNotes() async {
    __notes = await _noteService.getNotes();
    notifyListeners();
    return __notes;
  }

  Future<bool> deleteNote(String id) async {
    bool result = await _noteService.deleteNote(id);

    notifyListeners();
    return result;
  }

  Future<Note> addNote(Note note) async {
    Note result = await _noteService.createNote(note);
    notifyListeners();
    return result;
  }

  Future<Note> updateNote(Note note) async {
    Note result = await _noteService.updateNote(note);
    notifyListeners();
    return result;
  }
}
