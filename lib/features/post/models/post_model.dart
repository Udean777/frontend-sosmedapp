// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:client/core/models/user_model.dart';

class PostModel {
  final String id;
  final String image_url;
  final String caption;
  final UserModel user;
  PostModel({
    required this.id,
    required this.image_url,
    required this.caption,
    required this.user,
  });

  PostModel copyWith({
    String? id,
    String? image_url,
    String? caption,
    UserModel? user,
  }) {
    return PostModel(
      id: id ?? this.id,
      image_url: image_url ?? this.image_url,
      caption: caption ?? this.caption,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_url': image_url,
      'caption': caption,
      'user': user.toMap(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      image_url: map['image_url'] as String,
      caption: map['caption'] as String,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(id: $id, image_url: $image_url, caption: $caption, user: $user)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image_url == image_url &&
        other.caption == caption &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^ image_url.hashCode ^ caption.hashCode ^ user.hashCode;
  }
}
