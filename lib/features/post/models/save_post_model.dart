// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';
import 'package:hive/hive.dart';

part 'save_post_model.g.dart';

@HiveType(typeId: 0)
class SavePostModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String post_id;

  @HiveField(2)
  final String user_id;

  @HiveField(3)
  final DateTime created_at;

  @HiveField(4)
  final DateTime updated_at;

  SavePostModel({
    required this.id,
    required this.post_id,
    required this.user_id,
    required this.created_at,
    required this.updated_at,
  });

  SavePostModel copyWith({
    String? id,
    String? post_id,
    String? user_id,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return SavePostModel(
      id: id ?? this.id,
      post_id: post_id ?? this.post_id,
      user_id: user_id ?? this.user_id,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'post_id': post_id,
      'user_id': user_id,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory SavePostModel.fromMap(Map<String, dynamic> map) {
    return SavePostModel(
      id: map['id'] ?? "",
      post_id: map['post_id'] ?? "",
      user_id: map['user_id'] ?? "",
      created_at: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updated_at: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory SavePostModel.fromJson(String source) =>
      SavePostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SavePostModel(id: $id, post_id: $post_id, user_id: $user_id, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant SavePostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.post_id == post_id &&
        other.user_id == user_id &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        post_id.hashCode ^
        user_id.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
