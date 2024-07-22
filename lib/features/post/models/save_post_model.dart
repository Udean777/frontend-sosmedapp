// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class SavePostModel {
  final String id;
  final String post_id;
  final String user_id;
  SavePostModel({
    required this.id,
    required this.post_id,
    required this.user_id,
  });

  SavePostModel copyWith({
    String? id,
    String? post_id,
    String? user_id,
  }) {
    return SavePostModel(
      id: id ?? this.id,
      post_id: post_id ?? this.post_id,
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'post_id': post_id,
      'user_id': user_id,
    };
  }

  factory SavePostModel.fromMap(Map<String, dynamic> map) {
    return SavePostModel(
      id: map['id'] ?? "",
      post_id: map['post_id'] ?? "",
      user_id: map['user_id'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SavePostModel.fromJson(String source) =>
      SavePostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SavePostModel(id: $id, post_id: $post_id, user_id: $user_id)';

  @override
  bool operator ==(covariant SavePostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.post_id == post_id &&
        other.user_id == user_id;
  }

  @override
  int get hashCode => id.hashCode ^ post_id.hashCode ^ user_id.hashCode;
}
