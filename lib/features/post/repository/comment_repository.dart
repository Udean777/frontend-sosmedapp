import 'dart:convert';

import 'package:client/core/constants/server_constants.dart';
import 'package:client/core/failure/failure_app.dart';
import 'package:client/core/models/comment_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'comment_repository.g.dart';

@riverpod
CommentRepository commentRepository(CommentRepositoryRef ref) {
  return CommentRepository();
}

class CommentRepository {
  Future<Either<FailureApp, List<CommentModel>>> getComments({
    required String token,
    required String postId,
  }) async {
    try {
      final res = await http.get(
          Uri.parse("${ServerConstants.serverUrl}/post/$postId/comments"),
          headers: {
            "Content-Type": "application/json",
            "x-auth-token": token,
          });

      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 200) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(FailureApp(resBodyMap["message"]));
      }

      resBodyMap = resBodyMap as List;

      List<CommentModel> comments = [];

      for (var map in resBodyMap) {
        comments.add(CommentModel.fromMap(map));
      }

      return Right(comments);
    } catch (e) {
      return Left(FailureApp(e.toString()));
    }
  }

  Future<Either<FailureApp, CommentModel>> addComment({
    required String token,
    required String postId,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("${ServerConstants.serverUrl}/post/comments"),
        headers: {
          "Content-Type": "application/json",
          "x-auth-token": token,
        },
        body: jsonEncode(
          {
            "content": content,
            "postId": postId,
            "created_at": createdAt.toIso8601String(),
            "updated_at": updatedAt.toIso8601String(),
          },
        ),
      );

      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 201) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(FailureApp(resBodyMap["detail"]));
      }

      return Right(CommentModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(FailureApp(e.toString()));
    }
  }
}
