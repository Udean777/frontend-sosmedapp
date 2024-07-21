import 'dart:convert';

import 'package:client/core/constants/server_constants.dart';
import 'package:client/core/failure/failure_app.dart';
import 'package:client/features/post/models/post_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'post_repository.g.dart';

@riverpod
PostRepository postRepository(PostRepositoryRef ref) {
  return PostRepository();
}

class PostRepository {
  Future<Either<FailureApp, List<PostModel>>> getAllPosts(
      {required String token}) async {
    try {
      final res = await http.get(
          Uri.parse("${ServerConstants.serverUrl}/post/list"),
          headers: {"Content-Type": "application/json", "x-auth-token": token});

      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 200) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(FailureApp(resBodyMap["detail"]));
      }

      resBodyMap = resBodyMap as List;

      List<PostModel> posts = [];

      for (var map in resBodyMap) {
        posts.add(PostModel.fromMap(map));
      }

      return Right(posts);
    } catch (e) {
      return Left(FailureApp(e.toString()));
    }
  }
}
