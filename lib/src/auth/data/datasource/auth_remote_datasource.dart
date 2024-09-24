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
    final res = await dio.post('$kBaseUrl/user', data: {
      'name': name,
      'avatar': avatar,
      'createdAt': createdAt,
    });

    if (res.statusCode != 200 && res.statusCode != 201) {
      throw ServerException(
          message: res.statusMessage!, statusCode: res.statusCode!);
    }
  }

  @override
  Future<List<UserModel>> getUser() async {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
