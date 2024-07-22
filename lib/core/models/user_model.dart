// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:client/features/post/models/save_post_model.dart';

class UserModel {
  final String username;
  final String email;
  final String id;
  final String token;
  final List<SavePostModel> savedPosts;
  UserModel({
    required this.username,
    required this.email,
    required this.id,
    required this.token,
    required this.savedPosts,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? id,
    String? token,
    List<SavePostModel>? savedPosts,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      id: id ?? this.id,
      token: token ?? this.token,
      savedPosts: savedPosts ?? this.savedPosts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'id': id,
      'token': token,
      'savedPosts': savedPosts.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? "",
      email: map['email'] ?? "",
      id: map['id'] ?? "",
      token: map['token'] ?? "",
      savedPosts: map['savedPosts'] != null
          ? List<SavePostModel>.from(
              (map['savedPosts'] as List<dynamic>).map(
                (x) => SavePostModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [], // Handle null case for savedPosts
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, id: $id, token: $token, savedPosts: $savedPosts)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.id == id &&
        other.token == token &&
        listEquals(other.savedPosts, savedPosts);
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        id.hashCode ^
        token.hashCode ^
        savedPosts.hashCode;
  }
}
