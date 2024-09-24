import 'package:dartz/dartz.dart';
import 'package:tdd_practice/core/error/exception.dart';
import 'package:tdd_practice/core/error/failure.dart';
import 'package:tdd_practice/core/utils/typedef.dart';
import 'package:tdd_practice/src/auth/data/datasource/auth_remote_datasource.dart';
import 'package:tdd_practice/src/auth/domain/entities/user.dart';
import 'package:tdd_practice/src/auth/domain/repository/auth_repositiory.dart';

class AuthRepositioryImpl implements AuthRepositiory {
  final AuthRemoteDataSource _authRemoteDataSource;
  const AuthRepositioryImpl(this._authRemoteDataSource);

  @override
  ResultVoid createUser(
      {required String name,
      required String avatar,
      required String createdAt}) async {
    try {
      await _authRemoteDataSource.createUser(
        name: name,
        avatar: avatar,
        createdAt: createdAt,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }

  @override
  ResultFuture<List<User>> getUser() async {
    try {
      final result = await _authRemoteDataSource.getUser();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    }
  }
}
