part of 'event_cubit.dart';

@freezed
class EventState with _$EventState {
  const factory EventState.initial() = EventInitialState;

  // States for GetEventList
  const factory EventState.getEventListLoading() = GetEventListLoadingState;
  const factory EventState.getEventListSuccess(List<EventEntity> data) =
      GetEventListSuccessState;
  const factory EventState.getEventListFailure(String message) =
      GetEventListFailureState;

  // States for CreateEvent
  const factory EventState.createEventLoading() = CreateEventLoadingState;
  const factory EventState.createEventSuccess() = CreateEventSuccessState;
  const factory EventState.createEventFailure(String message) =
      CreateEventFailureState;

  // States for UpdateEvent
  const factory EventState.updateEventLoading() = UpdateEventLoadingState;
  const factory EventState.updateEventSuccess() = UpdateEventSuccessState;
  const factory EventState.updateEventFailure(String message) =
      UpdateEventFailureState;

  // States for DeleteEvent
  const factory EventState.deleteEventLoading() = DeleteEventLoadingState;
  const factory EventState.deleteEventSuccess() = DeleteEventSuccessState;
  const factory EventState.deleteEventFailure(String message) =
      DeleteEventFailureState;
}
