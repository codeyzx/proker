import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'package:proker/src/core/errors/failures.dart';
import 'package:proker/src/core/usecase/usecase.dart';
import 'package:proker/src/features/event/domain/entities/event_entity.dart';
import 'package:proker/src/features/event/domain/repositories/event_repository.dart';

@lazySingleton
class GetEventListUseCase implements UseCase<List<EventEntity>, NoParams> {
  final EventRepository _repository;
  const GetEventListUseCase(this._repository);

  @override
  Future<Either<Failure, List<EventEntity>>> call(NoParams params) async {
    return await _repository.getAll();
  }
}
