part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class CreatingUser extends AuthState {
  const CreatingUser();
}

final class GetingUser extends AuthState {
  const GetingUser();
}

final class UserCreated extends AuthState {
  const UserCreated();
}

final class UserLoaded extends AuthState {
  final List<User> users;

  const UserLoaded(this.users);

  @override
  List<Object> get props => users.map((res) => res.id).toList();
}

final class AuthError extends AuthState {
  final String errorMessage;
  const AuthError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
