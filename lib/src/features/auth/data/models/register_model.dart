import 'package:proker/src/features/auth/domain/entities/user_entity.dart';

class RegisterModel extends UserEntity {
  const RegisterModel({
    required String name,
    required String email,
    required String password,
  }) : super(
          name: name,
          email: email,
          password: password,
        );

  RegisterModel copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return RegisterModel(
      name: name ?? (this.name ?? ""),
      email: email ?? (this.email ?? ""),
      password: password ?? (this.password ?? ""),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }
}
