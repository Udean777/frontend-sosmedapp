// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:client/core/models/user_model.dart';

class PostModel {
  final String id;
  final String image_url;
  final String caption;
  final UserModel user;
  final DateTime created_at;
  final DateTime updated_at;

  PostModel({
    required this.id,
    required this.image_url,
    required this.caption,
    required this.user,
    required this.created_at,
    required this.updated_at,
  });

  PostModel copyWith({
    String? id,
    String? image_url,
    String? caption,
    UserModel? user,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return PostModel(
      id: id ?? this.id,
      image_url: image_url ?? this.image_url,
      caption: caption ?? this.caption,
      user: user ?? this.user,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_url': image_url,
      'caption': caption,
      'user': user.toMap(),
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] ?? "",
      image_url: map['image_url'] ?? "",
      caption: map['caption'] ?? "",
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : UserModel(
              id: '', username: '', email: '', token: "", savedPosts: []),
      created_at: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
      updated_at: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(id: $id, image_url: $image_url, caption: $caption, user: $user, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image_url == image_url &&
        other.caption == caption &&
        other.user == user &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image_url.hashCode ^
        caption.hashCode ^
        user.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
