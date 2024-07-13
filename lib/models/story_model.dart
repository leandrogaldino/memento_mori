import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel {
  final String id;
  final String category;
  final DateTime date;
  final String title;
  final String body;
  final bool readed;
  final bool favorite;
  final String comment;

  StoryModel({required this.id, required this.category, required this.date, required this.title, required this.body, required this.readed, required this.favorite, required this.comment});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'date': date.millisecondsSinceEpoch,
      'title': title,
      'body': body,
      'readed': readed,
      'favorite': favorite,
      'comment': comment,
    };
  }

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    Timestamp dateTimestamp = map['date'] ?? Timestamp.now();
    DateTime date = dateTimestamp.toDate();
    return StoryModel(
      id: (map['id'] ?? '') as String,
      category: (map['category'] ?? '') as String,
      date: date,
      title: (map['title'] ?? '') as String,
      body: (map['body'] ?? '') as String,
      readed: (map['readed'] ?? false) as bool,
      favorite: (map['favorite'] ?? false) as bool,
      comment: (map['comment'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryModel.fromJson(String source) => StoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  StoryModel copyWith({
    String? id,
    String? category,
    DateTime? date,
    String? title,
    String? body,
    bool? readed,
    bool? favorite,
    String? comment,
  }) {
    return StoryModel(
      id: id ?? this.id,
      category: category ?? this.category,
      date: date ?? this.date,
      title: title ?? this.title,
      body: body ?? this.body,
      readed: readed ?? this.readed,
      favorite: favorite ?? this.favorite,
      comment: comment ?? this.comment,
    );
  }
}
