class NoteModel {
  final String title;
  final String subtitle;

  NoteModel({required this.title, required this.subtitle});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
    };
  }
}
