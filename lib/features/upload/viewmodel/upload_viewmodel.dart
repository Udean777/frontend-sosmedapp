// ignore_for_file: avoid_print

import 'dart:io';

import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/upload/repository/upload_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upload_viewmodel.g.dart';

@riverpod
class UploadViewmodel extends _$UploadViewmodel {
  late UploadRepository _uploadRepository;

  @override
  AsyncValue? build() {
    _uploadRepository = ref.watch(uploadRepositoryProvider);
    return null;
  }

  Future<void> uploadPost({
    required File selectedImage,
    required String caption,
  }) async {
    state = const AsyncValue.loading();
    final res = await _uploadRepository.uploadPost(
      selectedImage: selectedImage,
      caption: caption,
      token: ref.read(currentUserNotifierProvider)!.token,
    );

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };

    print(val);
  }
}
