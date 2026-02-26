enum PaymentMethod {
  wallet,
  card,
  cash,
}

enum PaymentStatus {
  pending,
  success,
  failed,
  refunded,
}

class Payment {
  final String id;
  final String userId;
  final String? errandId;
  final double amount;
  final String currency;
  final PaymentMethod method;
  final PaymentStatus status;
  final String? paymobOrderId;
  final DateTime createdAt;

  Payment({
    required this.id,
    required this.userId,
    this.errandId,
    required this.amount,
    this.currency = 'EGP',
    required this.method,
    required this.status,
    this.paymobOrderId,
    required this.createdAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      userId: json['user_id'],
      errandId: json['errand_id'],
      amount: (json['amount'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'EGP',
      method: PaymentMethod.values.firstWhere((e) => e.toString().split('.').last == json['method']),
      status: PaymentStatus.values.firstWhere((e) => e.toString().split('.').last == json['status']),
      paymobOrderId: json['paymob_order_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'errand_id': errandId,
      'amount': amount,
      'currency': currency,
      'method': method.toString().split('.').last,
      'status': status.toString().split('.').last,
      'paymob_order_id': paymobOrderId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

enum MembershipPlanType {
  none,
  basic,
  plus,
  elite,
}

enum MembershipStatus {
  active,
  expired,
  cancelled,
}

class Membership {
  final String id;
  final String userId;
  final MembershipPlanType plan;
  final DateTime startedAt;
  final DateTime expiresAt;
  final int errandsTotal;
  final int errandsUsed;
  final double monthlyCost;
  final bool autoRenew;
  final MembershipStatus status;

  Membership({
    required this.id,
    required this.userId,
    required this.plan,
    required this.startedAt,
    required this.expiresAt,
    required this.errandsTotal,
    required this.errandsUsed,
    required this.monthlyCost,
    this.autoRenew = true,
    required this.status,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      id: json['id'],
      userId: json['user_id'],
      plan: MembershipPlanType.values.firstWhere((e) => e.toString().split('.').last == json['plan']),
      startedAt: DateTime.parse(json['started_at']),
      expiresAt: DateTime.parse(json['expires_at']),
      errandsTotal: json['errands_total'],
      errandsUsed: json['errands_used'],
      monthlyCost: (json['monthly_cost_egp'] ?? 0.0).toDouble(),
      autoRenew: json['auto_renew'] ?? true,
      status: MembershipStatus.values.firstWhere((e) => e.toString().split('.').last == json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'plan': plan.toString().split('.').last,
      'started_at': startedAt.toIso8601String(),
      'expires_at': expiresAt.toIso8601String(),
      'errands_total': errandsTotal,
      'errands_used': errandsUsed,
      'monthly_cost_egp': monthlyCost,
      'auto_renew': autoRenew,
      'status': status.toString().split('.').last,
    };
  }
}

class WalletTransaction {
  final String id;
  final String userId;
  final double amount;
  final String type; // 'credit' or 'debit'
  final String description;
  final DateTime createdAt;

  WalletTransaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.description,
    required this.createdAt,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    return WalletTransaction(
      id: json['id'],
      userId: json['user_id'],
      amount: (json['amount'] ?? 0.0).toDouble(),
      type: json['type'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'type': type,
      'description': description,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
