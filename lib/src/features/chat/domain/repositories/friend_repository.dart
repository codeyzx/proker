import 'package:fpdart/fpdart.dart';
import 'package:proker/src/features/auth/domain/entities/user_entity.dart';

abstract class FriendRepository {
  Stream<Either<String, List<UserEntity>>> watchFriends();
}
