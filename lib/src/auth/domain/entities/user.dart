import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String createdAt;
  final String avatar;

  const User({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.avatar,
  });

  const User.empty()
      : this(
          id: "empty.id",
          name: 'empty.name',
          createdAt: 'empty.createdAt',
          avatar: 'empty.avatar',
        );

  @override
  List<Object?> get props => [id, name, avatar];
}
