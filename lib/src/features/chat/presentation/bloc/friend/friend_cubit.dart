import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/features/auth/domain/entities/user_entity.dart';
import 'package:proker/src/features/chat/domain/repositories/friend_repository.dart';

part 'friend_state.dart';
part 'friend_cubit.freezed.dart';

@injectable
class FriendCubit extends Cubit<FriendState> {
  FriendCubit(this.friendRepository) : super(const FriendState.initial());
  final FriendRepository friendRepository;

  void streamAllFriends() async {
    emit(const FriendState.loading());
    friendRepository.watchFriends().listen((event) {
      event.fold(
        (l) {
          emit(const FriendState.error("Error"));
        },
        (r) {
          emit(FriendState.success(r));
        },
      );
    });
  }
}
