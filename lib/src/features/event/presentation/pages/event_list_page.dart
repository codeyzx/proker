import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/core/utils/show_snackbar.dart';
import 'package:proker/src/features/event/domain/entities/event_entity.dart';
import 'package:proker/src/features/event/domain/usecases/usecase_params.dart';
import 'package:proker/src/features/event/presentation/bloc/event/event_cubit.dart';

@RoutePage()
class EventListPage extends StatelessWidget {
  const EventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EventCubit>()..getAll(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Event List'),
        ),
        body: BlocListener<EventCubit, EventState>(
          listener: (context, state) {
            if (state is DeleteEventSuccessState) {
              showSnackBar(
                  context, Colors.green, 'Event deleted successfully.');
              context.read<EventCubit>().getAll();
            } else if (state is DeleteEventFailureState) {
              showSnackBar(context, Colors.red, state.message);
            } else if (state is GetEventListFailureState) {
              showSnackBar(context, Colors.red, state.message);
            }
          },
          child: BlocBuilder<EventCubit, EventState>(
            builder: (context, state) {
              if (state is GetEventListLoadingState ||
                  state is DeleteEventLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetEventListSuccessState) {
                final events = state.data;
                return events.isEmpty
                    ? const Center(child: Text('No events available.'))
                    : ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return EventCard(event: event);
                        },
                      );
              } else {
                return const Center(child: Text('Unexpected state'));
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.router.push(const CreateEventRoute());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventEntity event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(event.title ?? 'No Title'),
        subtitle: Text(event.description ?? 'No Description'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _deleteEvent(context, event),
        ),
      ),
    );
  }

  void _deleteEvent(BuildContext context, EventEntity event) {
    context.read<EventCubit>().delete(DeleteEventParams(id: event.id ?? ''));
  }
}
