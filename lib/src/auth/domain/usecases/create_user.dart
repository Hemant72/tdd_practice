import 'package:equatable/equatable.dart';
import 'package:tdd_practice/core/usecase/usecase.dart';
import 'package:tdd_practice/core/utils/typedef.dart';
import 'package:tdd_practice/src/auth/domain/repository/auth_repositiory.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  final AuthRepositiory _authRepositiory;

  CreateUser(this._authRepositiory);

  ResultVoid createUser({
    required String name,
    required String avatar,
    required String createdAt,
  }) async {
    return _authRepositiory.createUser(
      name: name,
      avatar: avatar,
      createdAt: createdAt,
    );
  }

  @override
  ResultFuture<void> call(CreateUserParams params) async {
    return _authRepositiory.createUser(
      name: params.name,
      avatar: params.avatar,
      createdAt: params.createdAt,
    );
  }
}

class CreateUserParams extends Equatable {
  final String name;
  final String avatar;
  final String createdAt;

  const CreateUserParams({
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [name, avatar, createdAt];
}
