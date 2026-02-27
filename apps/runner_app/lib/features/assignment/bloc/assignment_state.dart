import 'package:models/models.dart';

enum AssignmentStatus { initial, loading, success, error }

class AssignmentState {
  final AssignmentStatus status;
  final List<Errand> assignments;
  final bool isAvailable;
  final String? errorMessage;

  AssignmentState({
    this.status = AssignmentStatus.initial,
    this.assignments = const [],
    this.isAvailable = false,
    this.errorMessage,
  });

  AssignmentState copyWith({
    AssignmentStatus? status,
    List<Errand>? assignments,
    bool? isAvailable,
    String? errorMessage,
  }) {
    return AssignmentState(
      status: status ?? this.status,
      assignments: assignments ?? this.assignments,
      isAvailable: isAvailable ?? this.isAvailable,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
