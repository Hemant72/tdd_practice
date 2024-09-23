import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_practice/src/auth/domain/entities/user.dart';
import 'package:tdd_practice/src/auth/domain/repository/auth_repositiory.dart';
import 'package:tdd_practice/src/auth/domain/usecases/get_user.dart';

import 'auth_repositiory.mock.dart';


void main() {
  late AuthRepositiory repositiory;
  late GetUser usecase;

  setUp(() {
    repositiory = MockAuthRepsoitory();
    usecase = GetUser(repositiory);
  });

  const tResponse = [User.empty()];

  //Arrage
  test("should call the [AuthRepositiory.getUser] and return [List<User>]", () async {
    when(() => repositiory.getUser()).thenAnswer(
      (_) async => const Right(tResponse),
    );
    //Act

    final result = await usecase();

    //Assert
    expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
    verify(() => repositiory.getUser()).called(1);
    verifyNoMoreInteractions(repositiory);
  });
}
