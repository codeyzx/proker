import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/usecase/usecase.dart';
import 'package:proker/src/core/utils/failure_converter.dart';
import 'package:proker/src/core/utils/logger.dart';
import 'package:proker/src/features/event/domain/entities/event_entity.dart';
import 'package:proker/src/features/event/domain/usecases/create_event_usecase.dart';
import 'package:proker/src/features/event/domain/usecases/delete_event_usecase.dart';
import 'package:proker/src/features/event/domain/usecases/get_event_list_usecase.dart';
import 'package:proker/src/features/event/domain/usecases/update_event_usecase.dart';
import 'package:proker/src/features/event/domain/usecases/usecase_params.dart';

part 'event_cubit.freezed.dart';
part 'event_state.dart';

@injectable
class EventCubit extends Cubit<EventState> {
  final CreateEventUseCase _createEvent;
  final DeleteEventUseCase _deleteEvent;
  final GetEventListUseCase _getEventList;
  final UpdateEventUseCase _updateEvent;

  EventCubit(
    this._createEvent,
    this._deleteEvent,
    this._getEventList,
    this._updateEvent,
  ) : super(const EventState.initial());

  Future<void> create(CreateEventParams event) async {
    emit(const EventState.createEventLoading());

    final result = await _createEvent.call(
      CreateEventParams(
        title: event.title,
        description: event.description,
        bannerUrl: event.bannerUrl,
        category: event.category,
        createdBy: event.createdBy,
        documentationUrl: event.documentationUrl,
        endDate: event.endDate,
        location: event.location,
        startDate: event.startDate,
        status: event.status,
        benefits: event.benefits,
        type: event.type,
        upvoteCount: event.upvoteCount,
        galleryUrls: event.galleryUrls,
      ),
    );

    result.fold(
      (l) => emit(EventState.createEventFailure(mapFailureToMessage(l))),
      (r) => emit(const EventState.createEventSuccess()),
    );
  }

  Future<void> delete(
    DeleteEventParams event,
  ) async {
    emit(const EventState.deleteEventLoading());

    final result = await _deleteEvent.call(
      DeleteEventParams(
        id: event.id,
      ),
    );

    result.fold(
      (l) => emit(EventState.deleteEventFailure(mapFailureToMessage(l))),
      (r) => emit(const EventState.deleteEventSuccess()),
    );
  }

  Future<void> getAll() async {
    emit(const EventState.getEventListLoading());

    final result = await _getEventList.call(NoParams());

    result.fold(
      (l) => emit(EventState.getEventListFailure(mapFailureToMessage(l))),
      (r) => emit(EventState.getEventListSuccess(r)),
    );
  }

  Future<void> update(
    UpdateEventParams event,
  ) async {
    emit(const EventState.updateEventLoading());

    final result = await _updateEvent.call(
      UpdateEventParams(
        id: event.id,
        title: event.title,
        description: event.description,
        status: event.status,
        startDate: event.startDate,
        endDate: event.endDate,
        location: event.location,
        createdBy: event.createdBy,
        type: event.type,
        benefits: event.benefits,
        bannerUrl: event.bannerUrl,
        category: event.category,
        upvoteCount: event.upvoteCount,
        documentationUrl: event.documentationUrl,
        galleryUrls: event.galleryUrls,
      ),
    );

    result.fold(
      (l) => emit(EventState.updateEventFailure(mapFailureToMessage(l))),
      (r) => emit(const EventState.updateEventSuccess()),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE EventCubit =====");
    return super.close();
  }

  void filterEvents({
    String? searchText,
    bool? isNewSelected,
    bool? isUpcomingSelected,
    bool? isDoneSelected,
    List<String>? selectedCategories,
    List<EventEntity>? allevents,
  }) {
    List<EventEntity> filteredEvents = allevents ?? [];

    if (searchText != null && searchText.isNotEmpty) {
      filteredEvents = filteredEvents
          .where((event) =>
              event.title?.toLowerCase().contains(searchText.toLowerCase()) ??
              false)
          .toList();
    }

    if (isNewSelected == true) {
      filteredEvents = filteredEvents
          .where((event) => event.status?.toLowerCase() == 'new')
          .toList();
    } else if (isUpcomingSelected == true) {
      filteredEvents = filteredEvents
          .where((event) => event.status?.toLowerCase() == 'upcoming')
          .toList();
    } else if (isDoneSelected == true) {
      filteredEvents = filteredEvents
          .where((event) => event.status?.toLowerCase() == 'done')
          .toList();
    }

    if (selectedCategories != null && selectedCategories.isNotEmpty) {
      filteredEvents = filteredEvents.where((event) {
        final eventCategories = event.category?.split(', ') ?? [];
        return selectedCategories.any(
            (category) => eventCategories.contains(category.toLowerCase()));
      }).toList();
    }

    emit(GetEventListSuccessState(filteredEvents));
  }

  void searchEvents(String searchText) {}
}
