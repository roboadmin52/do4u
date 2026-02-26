import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/errand_repository.dart';
import 'errand_creation_event.dart';
import 'errand_creation_state.dart';

class ErrandCreationBloc extends Bloc<ErrandCreationEvent, ErrandCreationState> {
  final ErrandRepository _repository;

  ErrandCreationBloc(this._repository) : super(ErrandCreationState()) {
    on<ErrandCategorySelected>(_onCategorySelected);
    on<ErrandDetailsUpdated>(_onDetailsUpdated);
    on<ErrandEstimateRequested>(_onEstimateRequested);
    on<ErrandSubmitRequested>(_onSubmitRequested);
  }

  void _onCategorySelected(
    ErrandCategorySelected event,
    Emitter<ErrandCreationState> emit,
  ) {
    emit(state.copyWith(
      status: ErrandCreationStatus.categorySelected,
      category: event.category,
    ));
  }

  void _onDetailsUpdated(
    ErrandDetailsUpdated event,
    Emitter<ErrandCreationState> emit,
  ) {
    emit(state.copyWith(
      status: ErrandCreationStatus.detailsEntered,
      subType: event.subType,
      description: event.description,
      pickupAddress: event.pickupAddress,
      dropoffAddress: event.dropoffAddress,
      isExpress: event.isExpress,
    ));
  }

  Future<void> _onEstimateRequested(
    ErrandEstimateRequested event,
    Emitter<ErrandCreationState> emit,
  ) async {
    emit(state.copyWith(status: ErrandCreationStatus.estimating));
    try {
      final estimate = await _repository.getPriceEstimate(
        category: state.category!,
        subType: state.subType!,
        pickupAddress: state.pickupAddress!,
        dropoffAddress: state.dropoffAddress,
        isExpress: state.isExpress,
      );
      emit(state.copyWith(status: ErrandCreationStatus.estimated, priceEstimate: estimate));
    } catch (e) {
      emit(state.copyWith(status: ErrandCreationStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onSubmitRequested(
    ErrandSubmitRequested event,
    Emitter<ErrandCreationState> emit,
  ) async {
    emit(state.copyWith(status: ErrandCreationStatus.submitting));
    try {
      final errandData = {
        'category': state.category!.toString().split('.').last,
        'sub_type': state.subType,
        'description': state.description,
        'pickup_address': state.pickupAddress,
        'dropoff_address': state.dropoffAddress,
        'is_express': state.isExpress,
        'payment_method': event.paymentMethod,
      };
      final errand = await _repository.createErrand(errandData);
      emit(state.copyWith(status: ErrandCreationStatus.success, createdErrand: errand));
    } catch (e) {
      emit(state.copyWith(status: ErrandCreationStatus.error, errorMessage: e.toString()));
    }
  }
}
