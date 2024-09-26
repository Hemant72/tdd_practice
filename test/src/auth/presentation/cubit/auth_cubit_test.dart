import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_practice/core/error/failure.dart';
import 'package:tdd_practice/src/auth/domain/entities/user.dart';
import 'package:tdd_practice/src/auth/domain/usecases/create_user.dart';
import 'package:tdd_practice/src/auth/domain/usecases/get_user.dart';
import 'package:tdd_practice/src/auth/presentation/cubit/auth_cubit.dart';

class MockGetUser extends Mock implements GetUser {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUser getUsers;
  late CreateUser createUsers;
  late AuthCubit authCubit;

  const tCreateUserParam = CreateUserParams.empty();

  setUp(() {
    getUsers = MockGetUser();
    createUsers = MockCreateUser();
    authCubit = AuthCubit(createUser: createUsers, getUser: getUsers);
    registerFallbackValue(tCreateUserParam);
  });

  test('initial state should be AuthInitial', () async {
    expect(authCubit.state, AuthInitial());
  });

  group("create user", () {
    blocTest<AuthCubit, AuthState>(
        "should emit the [CreatingUser, UserCreated] when successful",
        build: () {
          when(() => createUsers(any()))
              .thenAnswer((_) async => const Right(null));
          return authCubit;
        },
        act: (cubit) => cubit.createUserHandler(
              name: tCreateUserParam.name,
              avatar: tCreateUserParam.avatar,
              createdAt: tCreateUserParam.createdAt,
            ),
        expect: () => [const CreatingUser(), const UserCreated()],
        verify: (cubit) {
          verify(() => createUsers(tCreateUserParam)).called(1);
          verifyNoMoreInteractions(createUsers);
        });

    blocTest<AuthCubit, AuthState>(
        "should emit the [CreatingUser, AuthError] when unsuccessful",
        build: () {
          when(() => createUsers(any())).thenAnswer((_) async => const Left(
              ServerFailure(message: "error message", statusCode: 500)));
          return authCubit;
        },
        act: (cubit) => cubit.createUserHandler(
              name: tCreateUserParam.name,
              avatar: tCreateUserParam.avatar,
              createdAt: tCreateUserParam.createdAt,
            ),
        expect: () => [
              const CreatingUser(),
              const AuthError("error message"),
            ],
        verify: (cubit) {
          verify(() => createUsers(tCreateUserParam)).called(1);
          verifyNoMoreInteractions(createUsers);
        });
  });

  group("get user", () {
    blocTest(
      "should emit the [GetingUser, UserLoaded] when successful",
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Right([
              User(
                id: "id",
                name: "name",
                avatar: "avatar",
                createdAt: "createdAt",
              ),
            ]));
        return authCubit;
      },
      act: (cubit) => cubit.getUserHandler(),
      expect: () => [
        const GetingUser(),
        const UserLoaded([
          User(
            id: "id",
            name: "name",
            avatar: "avatar",
            createdAt: "createdAt",
          ),
        ])
      ],
    );

    blocTest("should emit the [GetingUser, AuthError] when unsuccessful",
        build: () {
          when(() => getUsers()).thenAnswer((_) async => const Left(
              ServerFailure(message: "error message", statusCode: 500)));
          return authCubit;
        },
        act: (cubit) => cubit.getUserHandler(),
        expect: () => [
              const GetingUser(),
              const AuthError("error message"),
            ],
        verify: (cubit) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });
  });

  tearDown(() {
    authCubit.close();
  });
}
