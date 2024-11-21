import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/cache/hive_local_storage.dart';
import 'package:proker/src/core/errors/exceptions.dart';
import 'package:proker/src/core/errors/failures.dart';
import 'package:proker/src/core/network/network_info.dart';
import 'package:proker/src/features/event/data/datasources/event_local_datasource.dart';
import 'package:proker/src/features/event/data/datasources/event_remote_datasource.dart';
import 'package:proker/src/features/event/data/models/models.dart';
import 'package:proker/src/features/event/domain/entities/event_entity.dart';
import 'package:proker/src/features/event/domain/repositories/event_repository.dart';
import 'package:proker/src/features/event/domain/usecases/usecase_params.dart';

@LazySingleton(as: EventRepository)
class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource _remoteDataSource;
  final EventLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  final HiveLocalStorage _localStorage;
  const EventRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
    this._localStorage,
  );

  @override
  Future<Either<Failure, void>> create(CreateEventParams params) async {
    try {
      final model = CreateEventModel(
        title: params.title,
        description: params.description,
        status: params.status,
        startDate: params.startDate,
        location: params.location,
        createdBy: params.createdBy,
        type: params.type,
        benefits: params.benefits,
        bannerUrl: params.bannerUrl,
        category: params.category,
        upvoteCount: params.upvoteCount,
      );

      final result = await _remoteDataSource.createEvent(model);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<EventEntity>>> getAll() {
    return _networkInfo.check<List<EventEntity>>(
      connected: () async {
        try {
          final listEvent = await _remoteDataSource.fetchEvent();
          await _localStorage.save(
            key: "events",
            value: EventModel.toMapList(listEvent),
            boxName: "cache",
          );

          return Right(listEvent);
        } on ServerException {
          return Left(ServerFailure());
        }
      },
      notConnected: () async {
        try {
          final listEvent = await _localDataSource.getAllEvent();

          return Right(listEvent);
        } on CacheException {
          return Left(CacheFailure());
        }
      },
    );
  }

  @override
  Future<Either<Failure, void>> delete(DeleteEventParams params) async {
    try {
      final model = DeleteEventModel(
        id: params.id,
      );

      final result = await _remoteDataSource.deleteEvent(model);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> update(UpdateEventParams params) async {
    try {
      final model = UpdateEventModel(
        id: params.id,
        title: params.title,
        description: params.description,
        status: params.status,
        startDate: params.startDate,
        location: params.location,
        createdBy: params.createdBy,
        type: params.type,
        benefits: params.benefits,
        bannerUrl: params.bannerUrl,
        category: params.category,
        upvoteCount: params.upvoteCount,
      );

      final result = await _remoteDataSource.updateEvent(model);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
