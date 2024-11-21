import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:proker/src/core/errors/failures.dart';
import 'package:proker/src/core/usecase/usecase.dart';
import 'package:proker/src/features/event/domain/repositories/event_repository.dart';

@lazySingleton
class DeleteEventUseCase implements UseCase<void, Params> {
  final EventRepository _repository;
  const DeleteEventUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    if (params.id == "") {
      return Left(EmptyFailure());
    }

    return await _repository.delete(params);
  }
}

class Params extends Equatable {
  final String id;

  const Params({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
