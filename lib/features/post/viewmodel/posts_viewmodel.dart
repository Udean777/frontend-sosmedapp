// ignore_for_file: avoid_print

import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/post/models/post_model.dart';
import 'package:client/features/post/models/save_post_model.dart';
import 'package:client/features/post/repository/post_local_repository.dart';
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

@riverpod
Future<List<PostModel>> getSavedPost(GetSavedPostRef ref) async {
  final token =
      ref.watch(currentUserNotifierProvider.select((user) => user!.token));
  final res = await ref.read(postRepositoryProvider).getSavedPost(token: token);

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class PostsViewmodel extends _$PostsViewmodel {
  late PostRepository _postRepository;
  late PostLocalRepository _localRepository;

  @override
  AsyncValue? build() {
    _postRepository = ref.read(postRepositoryProvider);
    _localRepository = ref.read(postLocalRepositoryProvider);
    return null;
  }

  Future<void> savedPost({required String postId}) async {
    state = const AsyncValue.loading();

    final now = DateTime.now();

    final res = await _postRepository.savedPost(
      token: ref.read(currentUserNotifierProvider)!.token,
      postId: postId,
    );

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => _savedPostSuccess(r, postId, now)
    };

    print("Result of savedPost: $val");
  }

  Future<AsyncValue<bool>> _savedPostSuccess(
      bool isSaved, String postId, DateTime now) async {
    final userNotifier = ref.read(currentUserNotifierProvider.notifier);
    final currentUser = ref.read(currentUserNotifierProvider)!;

    List<SavePostModel> savedPosts = await _localRepository.loadSavedPosts();
    print("Current saved posts: $savedPosts");

    if (isSaved) {
      final newSavedPost = SavePostModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        post_id: postId,
        user_id: currentUser.id,
        created_at: now,
        updated_at: now,
      );

      savedPosts = [...savedPosts, newSavedPost];
    } else {
      savedPosts =
          savedPosts.where((savePost) => savePost.post_id != postId).toList();
    }

    await _localRepository.savePosts(savedPosts);
    print("Updated saved posts: $savedPosts");

    final updatedUser = currentUser.copyWith(savedPosts: savedPosts);
    userNotifier.addUser(updatedUser);

    ref.invalidate(getSavedPostProvider);
    state = AsyncValue.data(isSaved);
    return AsyncValue.data(isSaved);
  }

  Future<void> loadSavedPosts() async {
    final savedPosts = await _localRepository.loadSavedPosts();
    final userNotifier = ref.read(currentUserNotifierProvider.notifier);
    final currentUser = ref.read(currentUserNotifierProvider)!;
    userNotifier.addUser(currentUser.copyWith(savedPosts: savedPosts));
  }
}
