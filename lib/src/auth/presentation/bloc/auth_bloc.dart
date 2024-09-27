import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_practice/src/auth/domain/entities/user.dart';
import 'package:tdd_practice/src/auth/domain/usecases/create_user.dart';
import 'package:tdd_practice/src/auth/domain/usecases/get_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUser _createUser;
  final GetUser _getUser;
  AuthBloc({
    required CreateUser createUser,
    required GetUser getUser,
  })  : _createUser = createUser,
        _getUser = getUser,
        super(AuthInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUserHandler);
  }

  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthState> emit) async {
    emit(const CreatingUser());
    final result = await _createUser(
      CreateUserParams(
        name: event.name,
        avatar: event.avatar,
        createdAt: event.createdAt,
      ),
    );
    result.fold((l) {
      emit(AuthError(l.message));
    }, (r) {
      emit(const UserCreated());
    });
  }

  Future<void> _getUserHandler(
      GetUserEvent event, Emitter<AuthState> emit) async {
    emit(const GetingUser());
    final result = await _getUser();
    return result.fold((l) {
      emit(AuthError(l.message));
    }, (r) {
      emit(UserLoaded(r));
    });
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    log(transition.toString());
  }
}
