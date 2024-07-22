// ignore_for_file: avoid_print

import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/post/models/post_model.dart';
import 'package:client/features/post/models/save_post_model.dart';
// import 'package:client/features/post/repository/post_local_repository.dart';
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
  // late PostLocalRepository _postLocalRepository;

  @override
  AsyncValue? build() {
    _postRepository = ref.read(postRepositoryProvider);
    // _postLocalRepository = ref.read(postLocalRepositoryProvider);
    return null;
  }

  Future<void> savedPost({required String postId}) async {
    state = const AsyncValue.loading();

    final res = await _postRepository.savedPost(
      token: ref.read(currentUserNotifierProvider)!.token,
      postId: postId,
    );

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => _savedPostSuccess(r, postId)
    };

    print(val);
  }

  AsyncValue _savedPostSuccess(bool isSaved, String postId) {
    final userNotifier = ref.read(currentUserNotifierProvider.notifier);

    if (isSaved) {
      userNotifier.addUser(
        ref.read(currentUserNotifierProvider)!.copyWith(
          savedPosts: [
            ...ref.read(currentUserNotifierProvider)!.savedPosts,
            SavePostModel(id: "", post_id: postId, user_id: ""),
          ],
        ),
      );
    } else {
      userNotifier.addUser(
        ref.read(currentUserNotifierProvider)!.copyWith(
              savedPosts: ref
                  .read(currentUserNotifierProvider)!
                  .savedPosts
                  .where(
                    (savePost) => savePost.post_id != postId,
                  )
                  .toList(),
            ),
      );
    }
    ref.invalidate(getSavedPostProvider);
    return state = AsyncValue.data(isSaved);
  }
}
