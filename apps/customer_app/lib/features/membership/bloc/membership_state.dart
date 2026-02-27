import 'package:models/models.dart';

enum MembershipStatus { initial, loading, success, error }

class MembershipState {
  final MembershipStatus status;
  final Membership? membership;
  final String? errorMessage;

  MembershipState({
    this.status = MembershipStatus.initial,
    this.membership,
    this.errorMessage,
  });

  MembershipState copyWith({
    MembershipStatus? status,
    Membership? membership,
    String? errorMessage,
  }) {
    return MembershipState(
      status: status ?? this.status,
      membership: membership ?? this.membership,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
