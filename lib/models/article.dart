import 'dart:convert';

import 'package:flutter/material.dart';

class Article {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final DateTime dateAdded;

  Article({
    this.id,
    this.title,
    this.imageUrl,
    this.description,
    this.dateAdded,
  });

  Article copyWith({
    String id,
    String title,
    String imageUrl,
    String description,
    DateTime dateAdded,
  }) {
    return Article(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'dateAdded': dateAdded?.millisecondsSinceEpoch,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map, String id) {
    if (map == null) return null;

    return Article(
      id: id,
      title: map['title'],
      imageUrl: map['imageUrl'],
      description: map['description'],
      dateAdded: DateTime.parse(map['dateAdded']),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Article(id: $id, title: $title, imageUrl: $imageUrl, description: $description, dateAdded: $dateAdded)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Article &&
        o.id == id &&
        o.title == title &&
        o.imageUrl == imageUrl &&
        o.description == description &&
        o.dateAdded == dateAdded;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        imageUrl.hashCode ^
        description.hashCode ^
        dateAdded.hashCode;
  }
}
