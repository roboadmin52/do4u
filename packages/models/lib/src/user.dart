class User {
  final String id;
  final String phone;
  final String fullName;
  final String? email;
  final String role;
  final String membershipPlan;
  final double walletBalance;

  User({
    required this.id,
    required this.phone,
    required this.fullName,
    this.email,
    required this.role,
    this.membershipPlan = 'none',
    this.walletBalance = 0.0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phone: json['phone'],
      fullName: json['full_name'],
      email: json['email'],
      role: json['role'],
      membershipPlan: json['membership_plan'] ?? 'none',
      walletBalance: (json['wallet_balance'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'full_name': fullName,
      'email': email,
      'role': role,
      'membership_plan': membershipPlan,
      'wallet_balance': walletBalance,
    };
  }
}
