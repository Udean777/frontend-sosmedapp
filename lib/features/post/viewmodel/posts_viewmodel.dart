import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/post/models/post_model.dart';
import 'package:client/features/post/repository/post_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_viewmodel.g.dart';

@riverpod
Future<List<PostModel>> getAllPosts(GetAllPostsRef ref) async {
  final token =
      ref.watch(currentUserNotifierProvider.select((user) => user!.token));
  final res = await ref.read(postRepositoryProvider).getAllPosts(token: token);

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}
