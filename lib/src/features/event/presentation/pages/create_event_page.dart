import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/features/event/domain/usecases/create_event_usecase.dart';
import 'package:proker/src/features/event/presentation/bloc/event/event_cubit.dart';

@RoutePage()
class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: 'Event Title');
  final _descriptionController = TextEditingController(
      text: 'Event Description. This is a sample description.');
  final _locationController =
      TextEditingController(text: 'Event Location. This is a sample location.');
  final _startDateController = TextEditingController(text: '2022-12-31');
  final _endDateController = TextEditingController(text: '2022-12-31');
  final _categoryController = TextEditingController(text: 'Event Category');

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventCubit>(
      create: (_) => getIt<EventCubit>(),
      child: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Create Event'),
          ),
          body: BlocListener<EventCubit, EventState>(
            listener: (context, state) {
              state.whenOrNull(
                createEventLoading: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                },
                createEventSuccess: () async {
                  context.router.back();
                  context.router.back();
                },
                createEventFailure: (error) {
                  Navigator.of(context, rootNavigator: true)
                      .pop(); // Close loading dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to create event: $error')),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Title is required'
                          : null,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Description is required'
                          : null,
                    ),
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(labelText: 'Location'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Location is required'
                          : null,
                    ),
                    TextFormField(
                      controller: _startDateController,
                      decoration: const InputDecoration(
                          labelText: 'Start Date (YYYY-MM-DD)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Start Date is required';
                        }
                        if (DateTime.tryParse(value) == null) {
                          return 'Invalid date format';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _endDateController,
                      decoration: const InputDecoration(
                          labelText: 'End Date (YYYY-MM-DD)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'End Date is required';
                        }
                        if (DateTime.tryParse(value) == null) {
                          return 'Invalid date format';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _categoryController,
                      decoration: const InputDecoration(labelText: 'Category'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Category is required'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          final params = Params(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            location: _locationController.text,
                            startDate:
                                DateTime.parse(_startDateController.text),
                            endDate: DateTime.parse(_endDateController.text),
                            category: _categoryController.text,
                            createdBy:
                                'currentUserId', // Replace with actual user ID
                          );

                          context.read<EventCubit>().create(params);
                          // context.router.maybePop(true);
                        }
                      },
                      child: const Text('Create Event'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
