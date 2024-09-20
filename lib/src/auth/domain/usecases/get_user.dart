import 'package:tdd_practice/core/usecase/usecase.dart';
import 'package:tdd_practice/core/utils/typedef.dart';
import 'package:tdd_practice/src/auth/domain/entities/user.dart';
import 'package:tdd_practice/src/auth/domain/repository/auth_repositiory.dart';

class GetUser extends UsecaseWithoutParams<List<User>> {
  final AuthRepositiory _authRepositiory;

  const GetUser(this._authRepositiory);

  @override
  ResultFuture<List<User>> call() async{
    return _authRepositiory.getUser();
  }
}
