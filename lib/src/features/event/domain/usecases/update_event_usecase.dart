import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/errors/failures.dart';
import 'package:proker/src/core/usecase/usecase.dart';
import 'package:proker/src/features/event/domain/repositories/event_repository.dart';

@lazySingleton
class UpdateEventUseCase implements UseCase<void, Params> {
  final EventRepository _repository;
  const UpdateEventUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    if (params.id == "") {
      return Left(EmptyFailure());
    }

    return await _repository.update(params);
  }
}

class Params extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;
  final String? createdBy;
  final String? type;
  final String? benefits;
  final String? bannerUrl;
  final String? category;
  final int? upvoteCount;
  final String? documentationUrl;
  final List<String>? galleryUrls;

  const Params({
    this.id,
    this.title,
    this.description,
    this.status,
    this.startDate,
    this.endDate,
    this.location,
    this.createdBy,
    this.type,
    this.benefits,
    this.bannerUrl,
    this.category,
    this.upvoteCount,
    this.documentationUrl,
    this.galleryUrls,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        startDate,
        endDate,
        location,
        createdBy,
        type,
        benefits,
        bannerUrl,
        category,
        upvoteCount,
        documentationUrl,
        galleryUrls,
      ];
}
