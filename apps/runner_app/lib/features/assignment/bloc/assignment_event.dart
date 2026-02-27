import 'package:models/models.dart';

abstract class AssignmentEvent {}

class AssignmentFetchRequested extends AssignmentEvent {}

class AssignmentStatusUpdated extends AssignmentEvent {
  final String errandId;
  final String status;
  AssignmentStatusUpdated(this.errandId, this.status);
}

class RunnerAvailabilityToggled extends AssignmentEvent {
  final bool isAvailable;
  RunnerAvailabilityToggled(this.isAvailable);
}
