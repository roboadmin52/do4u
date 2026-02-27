import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/membership_repository.dart';
import 'membership_event.dart';
import 'membership_state.dart';

class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  final MembershipRepository _repository;

  MembershipBloc(this._repository) : super(MembershipState()) {
    on<MembershipRequested>(_onRequested);
    on<MembershipSubscribeRequested>(_onSubscribeRequested);
  }

  Future<void> _onRequested(
    MembershipRequested event,
    Emitter<MembershipState> emit,
  ) async {
    emit(state.copyWith(status: MembershipStatus.loading));
    try {
      final membership = await _repository.getMyMembership();
      emit(state.copyWith(status: MembershipStatus.success, membership: membership));
    } catch (e) {
      emit(state.copyWith(status: MembershipStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onSubscribeRequested(
    MembershipSubscribeRequested event,
    Emitter<MembershipState> emit,
  ) async {
    emit(state.copyWith(status: MembershipStatus.loading));
    try {
      final membership = await _repository.subscribe(event.plan);
      emit(state.copyWith(status: MembershipStatus.success, membership: membership));
    } catch (e) {
      emit(state.copyWith(status: MembershipStatus.error, errorMessage: e.toString()));
    }
  }
}
