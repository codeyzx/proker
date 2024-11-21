import 'package:proker/src/features/event/domain/entities/event_entity.dart';

class DeleteEventModel extends EventEntity {
  const DeleteEventModel({
    required String id,
  }) : super(id: id);
}
