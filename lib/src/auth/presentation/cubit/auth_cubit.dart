import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_practice/src/auth/domain/entities/user.dart';
import 'package:tdd_practice/src/auth/domain/usecases/create_user.dart';
import 'package:tdd_practice/src/auth/domain/usecases/get_user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final CreateUser _createUser;
  final GetUser _getUser;
  AuthCubit({
    required CreateUser createUser,
    required GetUser getUser,
  })  : _createUser = createUser,
        _getUser = getUser,
        super(AuthInitial());

  Future<void> createUserHandler(
      {required String name,
      required String avatar,
      required String createdAt}) async {
    emit(const CreatingUser());
    final result = await _createUser(
      CreateUserParams(
        name: name,
        avatar: avatar,
        createdAt: createdAt,
      ),
    );
    result.fold((l) {
      emit(AuthError(l.message));
    }, (r) {
      emit(const UserCreated());
    });
  }

  Future<void> getUserHandler() async {
    emit(const GetingUser());
    final result = await _getUser();
    return result.fold((l) {
      emit(AuthError(l.message));
    }, (r) {
      emit(UserLoaded(r));
    });
  }
}
