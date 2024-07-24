// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:client/core/constants/server_constants.dart';
import 'package:client/core/failure/failure_app.dart';
import 'package:client/features/post/models/like_post_model.dart';
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

      print("API Response status code: ${res.statusCode}");
      print("API Response body: ${res.body}");

      if (res.statusCode != 200) {
        final errorBody = jsonDecode(res.body);
        return Left(
            FailureApp(errorBody["detail"] ?? "Unknown error occurred"));
      }

      final List<dynamic> resBodyList = jsonDecode(res.body);
      List<PostModel> posts = [];

      for (var map in resBodyList) {
        try {
          posts.add(PostModel.fromMap(map));
        } catch (e) {
          print("Error parsing post: $e");
          print("Problematic data: $map");
        }
      }

      return Right(posts);
    } catch (e) {
      print("Error in getAllPosts: $e");
      return Left(FailureApp(e.toString()));
    }
  }

  Future<Either<FailureApp, bool>> savedPost({
    required String token,
    required String postId,
  }) async {
    try {
      final res = await http.post(
          Uri.parse("${ServerConstants.serverUrl}/post/saved"),
          headers: {"Content-Type": "application/json", "x-auth-token": token},
          body: jsonEncode({"post_id": postId}));

      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 200) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(FailureApp(resBodyMap["detail"]));
      }

      return Right(resBodyMap["message"]);
    } catch (e) {
      return Left(FailureApp(e.toString()));
    }
  }

  Future<Either<FailureApp, List<PostModel>>> getSavedPost({
    required String token,
  }) async {
    try {
      final res = await http.get(
          Uri.parse("${ServerConstants.serverUrl}/post/list/saved"),
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

  Future<Either<FailureApp, bool>> likedPost({
    required String token,
    required String postId,
  }) async {
    try {
      final res = await http.post(
          Uri.parse("${ServerConstants.serverUrl}/post/liked"),
          headers: {"Content-Type": "application/json", "x-auth-token": token},
          body: jsonEncode({"post_id": postId}));

      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 200) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(FailureApp(resBodyMap["detail"]));
      }

      return Right(resBodyMap["message"]);
    } catch (e) {
      return Left(FailureApp(e.toString()));
    }
  }

  Future<Either<FailureApp, List<LikePostModel>>> getLikedPost({
    required String token,
  }) async {
    try {
      final res = await http.get(
          Uri.parse("${ServerConstants.serverUrl}/post/list/liked"),
          headers: {"Content-Type": "application/json", "x-auth-token": token});

      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 200) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(FailureApp(resBodyMap["detail"]));
      }

      resBodyMap = resBodyMap as List;

      List<LikePostModel> posts = [];

      for (var map in resBodyMap) {
        posts.add(LikePostModel.fromMap(map));
      }

      return Right(posts);
    } catch (e) {
      return Left(FailureApp(e.toString()));
    }
  }
}
