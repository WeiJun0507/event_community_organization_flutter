import 'package:flutter/material.dart';

import 'comment.dart';

class Post {
  String id;
  String content;
  String username;
  String userId;
  DateTime date;
  String downloadedLink;
  int likes;

  Post(this.id, this.userId, this.username, this.content, this.date, this.downloadedLink) : this.likes = 0;

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['description'],
        likes = json['likes'],
        username = json['username'],
        userId = json['userId'],
        downloadedLink = json['downloadedLink'],
        date = json['date'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'content': content,
        'likes': likes,
        'username': username,
        'userId': userId,
        'date': date,
        'downloadedLink': downloadedLink,
      };
}