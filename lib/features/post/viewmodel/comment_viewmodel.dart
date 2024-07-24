// ignore_for_file: avoid_print

import 'package:client/core/models/comment_model.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/post/repository/comment_repository.dart';
import 'package:client/features/post/viewmodel/posts_viewmodel.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comment_viewmodel.g.dart';

@riverpod
class CommentViewmodel extends _$CommentViewmodel {
  late CommentRepository _commentRepository;

  @override
  AsyncValue? build() {
    _commentRepository = ref.read(commentRepositoryProvider);
    return null;
  }

  Future<void> addComment({
    required String postId,
    required String content,
  }) async {
    state = const AsyncValue.loading();

    final now = DateTime.now();

    final res = await _commentRepository.addComment(
      token: ref.read(currentUserNotifierProvider)!.token,
      postId: postId,
      content: content,
      createdAt: now,
      updatedAt: now,
    );

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => _addCommentSuccess(r)
    };

    print("Result of addComment: $val");
  }

  Future<AsyncValue<CommentModel>> _addCommentSuccess(
    CommentModel comment,
  ) async {
    ref.invalidate(getAllPostsProvider);
    state = AsyncValue.data(comment);
    return AsyncValue.data(comment);
  }
}
