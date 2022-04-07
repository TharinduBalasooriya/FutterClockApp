class Note {
  String id;
  String title;
  String description;
  String createdDate;
  String? noteColor;
  int red;
  int green;
  int blue;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.noteColor,
    required this.blue,
    required this.green,
    required this.red,

    // required this.createdDate,
    // required this.noteColor
  });

  factory Note.fromJSON(Map<String, dynamic> data) {
    return Note(
      id: data['_id'],
      title: data['title'],
      description: data['description'],
      createdDate: data['createdDate'],
      noteColor: data['noteColor'],
      red: data['red'],
      green: data['green'],
      blue: data['blue'],
    );
  }
}
