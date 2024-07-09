import 'dart:convert';

class StoryModel {
  final String id;
  final String category;
  final DateTime date;
  final String title;
  final String imagePath;
  final String body;
  final bool readed;
  final bool favorite;
  final String comment;

  StoryModel({required this.id, required this.category, required this.date, required this.title, required this.imagePath, required this.body, required this.readed, required this.favorite, required this.comment});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'date': date.millisecondsSinceEpoch,
      'title': title,
      'imagePath': imagePath,
      'body': body,
      'readed': readed,
      'favorite': favorite,
      'comment': comment,
    };
  }

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      id: (map['id'] ?? '') as String,
      category: (map['category'] ?? '') as String,
      date: DateTime.fromMillisecondsSinceEpoch((map['date'] ?? 0) as int),
      title: (map['title'] ?? '') as String,
      imagePath: (map['imagePath'] ?? '') as String,
      body: (map['body'] ?? '') as String,
      readed: (map['readed'] ?? false) as bool,
      favorite: (map['favorite'] ?? false) as bool,
      comment: (map['comment'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryModel.fromJson(String source) => StoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
