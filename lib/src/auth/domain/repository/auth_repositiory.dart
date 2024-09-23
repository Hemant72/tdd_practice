import 'package:tdd_practice/core/utils/typedef.dart';
import 'package:tdd_practice/src/auth/domain/entities/user.dart';

abstract class AuthRepositiory {
  const AuthRepositiory();

  ResultVoid createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  ResultFuture<List<User>> getUser();
}
