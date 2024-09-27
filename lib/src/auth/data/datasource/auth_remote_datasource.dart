import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tdd_practice/core/error/exception.dart';
import 'package:tdd_practice/core/utils/constants.dart';
import 'package:tdd_practice/src/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  Future<List<UserModel>> getUser();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDatasourceImpl(this.dio);

  @override
  Future<void> createUser(
      {required String name,
      required String avatar,
      required String createdAt}) async {
    try {
      final res = await dio.post('$kBaseUrl/user', data: {
        'name': name,
        'avatar': avatar,
        'createdAt': createdAt,
      });

      if (res.statusCode != 200 && res.statusCode != 201) {
        throw ServerException(
            message: res.statusMessage!, statusCode: res.statusCode!);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<UserModel>> getUser() async {
    try {
      final res = await dio.get('$kBaseUrl/user');

      if (res.statusCode != 200 && res.statusCode != 201) {
        throw ServerException(
            message: res.statusMessage!, statusCode: res.statusCode!);
      }

      final jsonResponse = (res.data is String)
          ? jsonDecode(res.data) as List<dynamic>
          : res.data as List<dynamic>;

      final data = jsonResponse
          .map((map) => UserModel.fromMap(map as Map<String, dynamic>))
          .toList();

      return data;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }
}
