import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        password,
      ];
}
