enum ErrandCategory {
  government,
  shopping,
  pickupDropoff,
  queueing,
  car,
  custom,
}

enum ErrandStatus {
  draft,
  pendingPayment,
  confirmed,
  assigned,
  runnerEnRoute,
  runnerArrived,
  inProgress,
  returning,
  completed,
  rated,
  cancelled,
  issueReported,
}

class Errand {
  final String id;
  final int errandNumber;
  final String customerId;
  final String? runnerId;
  final ErrandCategory category;
  final String subType;
  final ErrandStatus status;
  final String description;
  final Map<String, dynamic> pickupAddress;
  final Map<String, dynamic>? dropoffAddress;
  final double baseFee;
  final double itemCost;
  final double totalPrice;
  final bool isExpress;
  final String paymentMethod;
  final String paymentStatus;

  Errand({
    required this.id,
    required this.errandNumber,
    required this.customerId,
    this.runnerId,
    required this.category,
    required this.subType,
    required this.status,
    required this.description,
    required this.pickupAddress,
    this.dropoffAddress,
    required this.baseFee,
    this.itemCost = 0.0,
    required this.totalPrice,
    this.isExpress = false,
    required this.paymentMethod,
    required this.paymentStatus,
  });

  factory Errand.fromJson(Map<String, dynamic> json) {
    return Errand(
      id: json['id'],
      errandNumber: json['errand_number'],
      customerId: json['customer_id'],
      runnerId: json['runner_id'],
      category: ErrandCategory.values.firstWhere((e) => e.toString().split('.').last == json['category']),
      subType: json['sub_type'],
      status: ErrandStatus.values.firstWhere((e) => e.toString().split('.').last == json['status']),
      description: json['description'],
      pickupAddress: json['pickup_address'],
      dropoffAddress: json['dropoff_address'],
      baseFee: (json['base_fee'] ?? 0.0).toDouble(),
      itemCost: (json['item_cost'] ?? 0.0).toDouble(),
      totalPrice: (json['total_price'] ?? 0.0).toDouble(),
      isExpress: json['is_express'] ?? false,
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'errand_number': errandNumber,
      'customer_id': customerId,
      'runner_id': runnerId,
      'category': category.toString().split('.').last,
      'sub_type': subType,
      'status': status.toString().split('.').last,
      'description': description,
      'pickup_address': pickupAddress,
      'dropoff_address': dropoffAddress,
      'base_fee': baseFee,
      'item_cost': itemCost,
      'total_price': totalPrice,
      'is_express': isExpress,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
    };
  }
}
