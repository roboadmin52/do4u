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

class ShoppingItem {
  final String name;
  final int quantity;
  final bool isPurchased;

  ShoppingItem({required this.name, this.quantity = 1, this.isPurchased = false});

  factory ShoppingItem.fromJson(Map<String, dynamic> json) => ShoppingItem(
        name: json['name'],
        quantity: json['quantity'] ?? 1,
        isPurchased: json['is_purchased'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'is_purchased': isPurchased,
      };
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
  final Map<String, dynamic>? categoryDetails;

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
    this.categoryDetails,
  });

  factory Errand.fromJson(Map<String, dynamic> json) {
    return Errand(
      id: json['id'],
      errandNumber: json['errand_number'],
      customerId: json['customer_id'],
      runnerId: json['runner_id'],
      category: _parseCategory(json['category']),
      subType: json['sub_type'],
      status: _parseStatus(json['status']),
      description: json['description'] ?? '',
      pickupAddress: json['pickup_address'],
      dropoffAddress: json['dropoff_address'],
      baseFee: (json['base_fee'] ?? 0.0).toDouble(),
      itemCost: (json['item_cost'] ?? 0.0).toDouble(),
      totalPrice: (json['total_price'] ?? 0.0).toDouble(),
      isExpress: json['is_express'] ?? false,
      paymentMethod: json['payment_method'] ?? 'cash',
      paymentStatus: json['payment_status'] ?? 'pending',
      categoryDetails: json['category_details'],
    );
  }

  static ErrandCategory _parseCategory(String value) {
    // Map snake_case or whatever to Enum
    final normalized = value.toLowerCase().replaceAll('_', '');
    return ErrandCategory.values.firstWhere(
      (e) => e.toString().split('.').last.toLowerCase().replaceAll('_', '') == normalized,
      orElse: () => ErrandCategory.custom,
    );
  }

  static ErrandStatus _parseStatus(String value) {
    final normalized = value.toLowerCase().replaceAll('_', '');
    return ErrandStatus.values.firstWhere(
      (e) => e.toString().split('.').last.toLowerCase().replaceAll('_', '') == normalized,
      orElse: () => ErrandStatus.draft,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'errand_number': errandNumber,
      'customer_id': customerId,
      'runner_id': runnerId,
      'category': _toSnakeCase(category.toString().split('.').last),
      'sub_type': subType,
      'status': _toSnakeCase(status.toString().split('.').last),
      'description': description,
      'pickup_address': pickupAddress,
      'dropoff_address': dropoffAddress,
      'base_fee': baseFee,
      'item_cost': itemCost,
      'total_price': totalPrice,
      'is_express': isExpress,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'category_details': categoryDetails,
    };
  }

  static String _toSnakeCase(String name) {
    // Specifically handle known camelCase to snake_case mappings
    if (name == 'pickupDropoff') return 'pickup_dropoff';
    if (name == 'pendingPayment') return 'pending_payment';
    if (name == 'runnerEnRoute') return 'runner_en_route';
    if (name == 'runnerArrived') return 'runner_arrived';
    if (name == 'inProgress') return 'in_progress';
    if (name == 'issueReported') return 'issue_reported';

    return name.replaceAllMapped(RegExp(r'([A-Z])'), (match) => '_${match.group(1)!.toLowerCase()}');
  }
}
