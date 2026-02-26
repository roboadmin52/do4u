import 'package:models/models.dart';

abstract class ErrandCreationEvent {}

class ErrandCategorySelected extends ErrandCreationEvent {
  final ErrandCategory category;
  ErrandCategorySelected(this.category);
}

class ErrandDetailsUpdated extends ErrandCreationEvent {
  final String subType;
  final String description;
  final Map<String, dynamic> pickupAddress;
  final Map<String, dynamic>? dropoffAddress;
  final bool isExpress;

  ErrandDetailsUpdated({
    required this.subType,
    required this.description,
    required this.pickupAddress,
    this.dropoffAddress,
    this.isExpress = false,
  });
}

class ErrandEstimateRequested extends ErrandCreationEvent {}

class ErrandSubmitRequested extends ErrandCreationEvent {
  final String paymentMethod;
  ErrandSubmitRequested(this.paymentMethod);
}
