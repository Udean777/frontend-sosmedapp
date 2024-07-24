// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:client/core/models/user_model.dart';

class CommentModel {
  final String id;
  final String post_id;
  final String user_id;
  final String content;
  final DateTime created_at;
  final DateTime? updated_at;
  final UserModel user;
  CommentModel({
    required this.id,
    required this.post_id,
    required this.user_id,
    required this.content,
    required this.created_at,
    required this.updated_at,
    required this.user,
  });

  CommentModel copyWith({
    String? id,
    String? post_id,
    String? user_id,
    String? content,
    DateTime? created_at,
    DateTime? updated_at,
    UserModel? user,
  }) {
    return CommentModel(
      id: id ?? this.id,
      post_id: post_id ?? this.post_id,
      user_id: user_id ?? this.user_id,
      content: content ?? this.content,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'post_id': post_id,
      'user_id': user_id,
      'content': content,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at?.millisecondsSinceEpoch,
      'user': user.toMap(),
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] ?? '',
      user_id: map['user_id'] ?? '',
      post_id: map['post_id'] ?? '',
      content: map['content'] ?? '',
      created_at: DateTime.parse(map['created_at']),
      updated_at:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommentModel(id: $id, post_id: $post_id, user_id: $user_id, content: $content, created_at: $created_at, updated_at: $updated_at, user: $user)';
  }

  @override
  bool operator ==(covariant CommentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.post_id == post_id &&
        other.user_id == user_id &&
        other.content == content &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        post_id.hashCode ^
        user_id.hashCode ^
        content.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        user.hashCode;
  }
}
