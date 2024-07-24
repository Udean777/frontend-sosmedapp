// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:client/core/models/comment_model.dart';
import 'package:client/core/models/user_model.dart';

class PostModel {
  final String id;
  final String image_url;
  final String caption;
  final UserModel user;
  final DateTime created_at;
  final DateTime? updated_at;
  final bool liked_by_user;
  final bool saved_by_user;
  final int likes_count;
  final int saves_count;
  final List<CommentModel> comments;

  PostModel({
    required this.id,
    required this.image_url,
    required this.caption,
    required this.user,
    required this.created_at,
    required this.updated_at,
    required this.liked_by_user,
    required this.saved_by_user,
    required this.likes_count,
    required this.saves_count,
    required this.comments,
  });

  PostModel copyWith({
    String? id,
    String? image_url,
    String? caption,
    UserModel? user,
    DateTime? created_at,
    DateTime? updated_at,
    bool? liked_by_user,
    bool? saved_by_user,
    int? likes_count,
    int? saves_count,
    List<CommentModel>? comments,
  }) {
    return PostModel(
      id: id ?? this.id,
      image_url: image_url ?? this.image_url,
      caption: caption ?? this.caption,
      user: user ?? this.user,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      liked_by_user: liked_by_user ?? this.liked_by_user,
      saved_by_user: saved_by_user ?? this.saved_by_user,
      likes_count: likes_count ?? this.likes_count,
      saves_count: saves_count ?? this.saves_count,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_url': image_url,
      'caption': caption,
      'user': user.toMap(),
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at?.millisecondsSinceEpoch,
      'liked_by_user': liked_by_user,
      'saved_by_user': saved_by_user,
      'likes_count': likes_count,
      'saves_count': saves_count,
      'comments': comments.map((x) => x.toMap()).toList(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] ?? '',
      image_url: map['image_url'] ?? '',
      caption: map['caption'] ?? '',
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      created_at: DateTime.parse(map['created_at']),
      updated_at:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      liked_by_user: map['liked_by_user'] ?? false,
      saved_by_user: map['saved_by_user'] ?? false,
      likes_count: map['likes_count'] ?? 0,
      saves_count: map['saves_count'] ?? 0,
      comments: List<CommentModel>.from(
        (map['comments'] as List<dynamic>).map<CommentModel>(
          (x) => CommentModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(id: $id, image_url: $image_url, caption: $caption, user: $user, created_at: $created_at, updated_at: $updated_at, liked_by_user: $liked_by_user, saved_by_user: $saved_by_user, likes_count: $likes_count, saves_count: $saves_count, comments: $comments)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image_url == image_url &&
        other.caption == caption &&
        other.user == user &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.liked_by_user == liked_by_user &&
        other.saved_by_user == saved_by_user &&
        other.likes_count == likes_count &&
        other.saves_count == saves_count &&
        listEquals(other.comments, comments);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image_url.hashCode ^
        caption.hashCode ^
        user.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        liked_by_user.hashCode ^
        saved_by_user.hashCode ^
        likes_count.hashCode ^
        saves_count.hashCode ^
        comments.hashCode;
  }
}
