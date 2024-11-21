import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/errors/failures.dart';
import 'package:proker/src/features/event/domain/entities/event_entity.dart';
import 'package:proker/src/features/event/domain/usecases/usecase_params.dart';

@factoryMethod
abstract class EventRepository {
  Future<Either<Failure, void>> create(CreateEventParams params);
  Future<Either<Failure, void>> delete(DeleteEventParams params);
  Future<Either<Failure, List<EventEntity>>> getAll();
  Future<Either<Failure, void>> update(UpdateEventParams params);
}
