import 'package:models/models.dart';

enum ErrandCreationStatus { initial, categorySelected, detailsEntered, estimating, estimated, submitting, success, error }

class ErrandCreationState {
  final ErrandCreationStatus status;
  final ErrandCategory? category;
  final String? subType;
  final String? description;
  final Map<String, dynamic>? pickupAddress;
  final Map<String, dynamic>? dropoffAddress;
  final bool isExpress;
  final Map<String, dynamic>? priceEstimate;
  final Errand? createdErrand;
  final String? errorMessage;

  ErrandCreationState({
    this.status = ErrandCreationStatus.initial,
    this.category,
    this.subType,
    this.description,
    this.pickupAddress,
    this.dropoffAddress,
    this.isExpress = false,
    this.priceEstimate,
    this.createdErrand,
    this.errorMessage,
  });

  ErrandCreationState copyWith({
    ErrandCreationStatus? status,
    ErrandCategory? category,
    String? subType,
    String? description,
    Map<String, dynamic>? pickupAddress,
    Map<String, dynamic>? dropoffAddress,
    bool? isExpress,
    Map<String, dynamic>? priceEstimate,
    Errand? createdErrand,
    String? errorMessage,
  }) {
    return ErrandCreationState(
      status: status ?? this.status,
      category: category ?? this.category,
      subType: subType ?? this.subType,
      description: description ?? this.description,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      dropoffAddress: dropoffAddress ?? this.dropoffAddress,
      isExpress: isExpress ?? this.isExpress,
      priceEstimate: priceEstimate ?? this.priceEstimate,
      createdErrand: createdErrand ?? this.createdErrand,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
