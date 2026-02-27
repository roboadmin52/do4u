import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/assignment_repository.dart';
import 'assignment_event.dart';
import 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final AssignmentRepository _repository;

  AssignmentBloc(this._repository) : super(AssignmentState()) {
    on<AssignmentFetchRequested>(_onFetchRequested);
    on<AssignmentStatusUpdated>(_onStatusUpdated);
    on<RunnerAvailabilityToggled>(_onAvailabilityToggled);
  }

  Future<void> _onFetchRequested(
    AssignmentFetchRequested event,
    Emitter<AssignmentState> emit,
  ) async {
    emit(state.copyWith(status: AssignmentStatus.loading));
    try {
      final assignments = await _repository.getAssignments();
      emit(state.copyWith(status: AssignmentStatus.success, assignments: assignments));
    } catch (e) {
      emit(state.copyWith(status: AssignmentStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onStatusUpdated(
    AssignmentStatusUpdated event,
    Emitter<AssignmentState> emit,
  ) async {
    try {
      await _repository.updateStatus(event.errandId, event.status);
      add(AssignmentFetchRequested());
    } catch (e) {
      emit(state.copyWith(status: AssignmentStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onAvailabilityToggled(
    RunnerAvailabilityToggled event,
    Emitter<AssignmentState> emit,
  ) async {
    try {
      final profile = await _repository.toggleAvailability(event.isAvailable);
      emit(state.copyWith(isAvailable: profile.isAvailable));
    } catch (e) {
      emit(state.copyWith(status: AssignmentStatus.error, errorMessage: e.toString()));
    }
  }
}
