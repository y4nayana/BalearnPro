class Note {
  int? id;
  String title;
  String description;

  Note({
    this.id,
    required this.title,
    required this.description,
  });

  // Konversi Note ke Map untuk database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  // Membuat Note dari Map hasil query database
  factory Note.fromMap(Map<String, dynamic> map) {
    if (map['title'] == null || map['description'] == null) {
      throw Exception('Data tidak valid: $map');
    }
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
