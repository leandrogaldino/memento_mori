class Story {
  final String id;
  final String category;
  final DateTime date;
  final String title;
  final String imagePath;
  final String body;
  final bool readed;
  final bool favorite;
  final String comment;

  Story({required this.id, required this.category, required this.date, required this.title, required this.imagePath, required this.body, required this.readed, required this.favorite, required this.comment});
}
