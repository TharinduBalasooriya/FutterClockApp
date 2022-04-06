class Note {
  String? id;
  String title;
  String description;
  String? createdDate;

  Note(
      {this.id,
      required this.title,
      required this.description,
      this.createdDate});

  factory Note.fromJSON(Map<String, dynamic> data) {
    return Note(
      id: data['_id'],
      title: data['title'],
      description: data['description'],
      createdDate: data['createdDate'],
    );
  }
}
