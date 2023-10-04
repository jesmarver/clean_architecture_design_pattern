import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  const User.empty()
      : this(
            avatar: '_empty.avatar',
            createdAt: '_empty.createdAt',
            id: '1',
            name: '_empty.name');

  @override
  List<Object?> get props => [id, name, avatar];
}
