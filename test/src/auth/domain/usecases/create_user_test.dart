import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_practice/src/auth/domain/repository/auth_repositiory.dart';
import 'package:tdd_practice/src/auth/domain/usecases/create_user.dart';

import 'auth_repositiory.mock.dart';

void main() {
  late AuthRepositiory repositiory;
  late CreateUser usecase;

  setUp(() {
    repositiory = MockAuthRepsoitory();
    usecase = CreateUser(repositiory);
  });

  const params = CreateUserParams.empty();

  test(
    "should call the [AuthRepositiory.createUser]",
    () async {
      // arrange
      when(() => repositiory.createUser(
            name: any(named: "name"),
            avatar: any(named: "avatar"),
            createdAt: any(named: "createdAt"),
          )).thenAnswer((_) async => const Right(null));

      // act
      final result = await usecase(params);

      //assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => repositiory.createUser(
            name: params.name,
            avatar: params.avatar,
            createdAt: params.createdAt),
      ).called(1);

      verifyNoMoreInteractions(repositiory);
    },
  );
}
