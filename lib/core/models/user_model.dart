// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:client/features/post/models/like_post_model.dart';
import 'package:client/features/post/models/save_post_model.dart';

class UserModel {
  final String username;
  final String email;
  final String id;
  final String token;
  final List<SavePostModel> savedPosts;
  final List<LikePostModel> likedPosts;
  UserModel({
    required this.username,
    required this.email,
    required this.id,
    required this.token,
    required this.savedPosts,
    required this.likedPosts,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? id,
    String? token,
    List<SavePostModel>? savedPosts,
    List<LikePostModel>? likedPosts,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      id: id ?? this.id,
      token: token ?? this.token,
      savedPosts: savedPosts ?? this.savedPosts,
      likedPosts: likedPosts ?? this.likedPosts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'id': id,
      'token': token,
      'savedPosts': savedPosts.map((x) => x.toMap()).toList(),
      'likedPosts': likedPosts.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? "",
      email: map['email'] ?? "",
      id: map['id'] ?? "",
      token: map['token'] ?? "",
      savedPosts: List<SavePostModel>.from(
        (map['savedPosts'] ?? []).map<SavePostModel>(
          (x) => SavePostModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      likedPosts: List<LikePostModel>.from(
        (map['likedPosts'] ?? []).map<LikePostModel>(
          (x) => LikePostModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, id: $id, token: $token, savedPosts: $savedPosts, likedPosts: $likedPosts)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.id == id &&
        other.token == token &&
        listEquals(other.savedPosts, savedPosts) &&
        listEquals(other.likedPosts, likedPosts);
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        id.hashCode ^
        token.hashCode ^
        savedPosts.hashCode ^
        likedPosts.hashCode;
  }
}
