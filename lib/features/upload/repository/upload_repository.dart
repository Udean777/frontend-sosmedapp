import 'dart:io';

import 'package:client/core/constants/server_constants.dart';
import 'package:client/core/failure/failure_app.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'upload_repository.g.dart';

@riverpod
UploadRepository uploadRepository(UploadRepositoryRef ref) {
  return UploadRepository();
}

class UploadRepository {
  Future<Either<FailureApp, String>> uploadPost({
    required File selectedImage,
    required String caption,
    required String token,
  }) async {
    try {
      final req = http.MultipartRequest(
        "POST",
        Uri.parse("${ServerConstants.serverUrl}/post/upload"),
      );

      req
        ..files.addAll(
          [
            await http.MultipartFile.fromPath('image_url', selectedImage.path),
          ],
        )
        ..fields.addAll(
          {
            'caption': caption,
          },
        )
        ..headers.addAll(
          {
            'x-auth-token': token,
          },
        );

      final res = await req.send();

      if (res.statusCode != 201) {
        return Left(FailureApp(await res.stream.bytesToString()));
      }

      return Right(await res.stream.bytesToString());
    } catch (e) {
      return Left(FailureApp(e.toString()));
    }
  }
}
