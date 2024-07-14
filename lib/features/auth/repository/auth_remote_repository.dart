// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:client/core/constants/server_constants.dart';
import 'package:client/core/failure/failure_app.dart';
import 'package:client/core/models/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<FailureApp, UserModel>> signup({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${ServerConstants.serverUrl}/auth/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "username": username,
            "email": email,
            "password": password,
          },
        ),
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return Left(FailureApp(resBodyMap['detail']));
      }

      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(FailureApp(e.toString()));
    }
  }

  Future<Either<FailureApp, UserModel>> signin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${ServerConstants.serverUrl}/auth/signin"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(FailureApp(resBodyMap['detail']));
      }

      return Right(
        UserModel.fromMap(resBodyMap['user']).copyWith(
          token: resBodyMap['token'],
        ),
      );
    } catch (e) {
      return Left(FailureApp(e.toString()));
    }
  }

  Future<Either<FailureApp, UserModel>> getCurrentUserData(String token) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ServerConstants.serverUrl}/auth/me',
        ),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(FailureApp(resBodyMap['detail']));
      }

      return Right(
        UserModel.fromMap(resBodyMap).copyWith(
          token: token,
        ),
      );
    } catch (e) {
      return Left(FailureApp(e.toString()));
    }
  }
}
