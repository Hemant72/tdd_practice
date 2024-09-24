import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_practice/core/error/exception.dart';
import 'package:tdd_practice/core/error/failure.dart';
import 'package:tdd_practice/src/auth/data/datasource/auth_remote_datasource.dart';
import 'package:tdd_practice/src/auth/data/repositiory/auth_repositiory_impl.dart';
import 'package:tdd_practice/src/auth/domain/entities/user.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource authRemoteDataSource;
  late AuthRepositioryImpl authRepositioryImpl;

  setUp(() {
    authRemoteDataSource = MockAuthRemoteDataSource();
    authRepositioryImpl = AuthRepositioryImpl(authRemoteDataSource);
  });

  group('create user', () {
    test(
        "should call the [RemoteDataSource.createuser] and return [List<User>] when the call to the remote source is successfull",
        () async {
      // arrange
      when(() => authRemoteDataSource.createUser(
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
            createdAt: any(named: 'createdAt'),
          )).thenAnswer((_) async => Future.value());
      // act
      final result = await authRepositioryImpl.createUser(
          name: 'name', avatar: 'avatar', createdAt: 'createdAt');
      // assert
      expect(result, equals(const Right(null)));

      verify(() => authRemoteDataSource.createUser(
            name: 'name',
            avatar: 'avatar',
            createdAt: 'createdAt',
          )).called(1);
      verifyNoMoreInteractions(authRemoteDataSource);
    });

    test(
        "should return a [Server failure] when the remote source is unsuccessful",
        () async {
      // arrange
      when(() => authRemoteDataSource.createUser(
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
            createdAt: any(named: 'createdAt'),
          )).thenThrow(const ServerException(
        message: 'unknown error occured',
        statusCode: 500,
      ));
      // act
      final result = await authRepositioryImpl.createUser(
          name: 'name', avatar: 'avatar', createdAt: 'createdAt');
      // assert
      verify(() => authRemoteDataSource.createUser(
            name: 'name',
            avatar: 'avatar',
            createdAt: 'createdAt',
          )).called(1);
      expect(
          result,
          equals(const Left(ServerFailure(
              message: 'unknown error occured', statusCode: 500))));
      verifyNoMoreInteractions(authRemoteDataSource);
    });
  });

  group("get user", () {
    test(
        "should call the [RemoteDataSource.getUser] and complete successfully when the call to the remote source is successfull",
        () async {
      // arrange
      when(() => authRemoteDataSource.getUser()).thenAnswer((_) async => []);
      // act
      final result = await authRepositioryImpl.getUser();
      // assert
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => authRemoteDataSource.getUser()).called(1);
      verifyNoMoreInteractions(authRemoteDataSource);
    });

    test(
        "should return a [Server failure] when the remote source is unsuccessful",
        () async {
      // arrange
      when(() => authRemoteDataSource.getUser())
          .thenThrow(const ServerException(
        message: 'message',
        statusCode: 500,
      ));
      // act
      final result = await authRepositioryImpl.getUser();
      // assert
      expect(
          result,
          equals(
              const Left(ServerFailure(message: "message", statusCode: 500))));
      verify(() => authRemoteDataSource.getUser()).called(1);
      verifyNoMoreInteractions(authRemoteDataSource);
    });
  });
}
