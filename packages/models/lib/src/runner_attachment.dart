enum VehicleType {
  motorcycle,
  car,
  onFoot,
}

class RunnerProfile {
  final String id;
  final String nationalId;
  final VehicleType vehicleType;
  final String licenseNumber;
  final List<String> specializations;
  final bool isAvailable;
  final int totalErrandsCompleted;
  final double averageRating;

  RunnerProfile({
    required this.id,
    required this.nationalId,
    required this.vehicleType,
    required this.licenseNumber,
    this.specializations = const [],
    this.isAvailable = false,
    this.totalErrandsCompleted = 0,
    this.averageRating = 0.0,
  });

  factory RunnerProfile.fromJson(Map<String, dynamic> json) {
    return RunnerProfile(
      id: json['id'],
      nationalId: json['national_id'],
      vehicleType: VehicleType.values.firstWhere((e) => e.toString().split('.').last == json['vehicle_type']),
      licenseNumber: json['license_number'],
      specializations: List<String>.from(json['specializations'] ?? []),
      isAvailable: json['is_available'] ?? false,
      totalErrandsCompleted: json['total_errands_completed'] ?? 0,
      averageRating: (json['average_rating'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'national_id': nationalId,
      'vehicle_type': vehicleType.toString().split('.').last,
      'license_number': licenseNumber,
      'specializations': specializations,
      'is_available': isAvailable,
      'total_errands_completed': totalErrandsCompleted,
      'average_rating': averageRating,
    };
  }
}

class ErrandAttachment {
  final String id;
  final String errandId;
  final String uploaderId;
  final String attachmentType;
  final String fileUrl;
  final DateTime uploadedAt;

  ErrandAttachment({
    required this.id,
    required this.errandId,
    required this.uploaderId,
    required this.attachmentType,
    required this.fileUrl,
    required this.uploadedAt,
  });

  factory ErrandAttachment.fromJson(Map<String, dynamic> json) {
    return ErrandAttachment(
      id: json['id'],
      errandId: json['errand_id'],
      uploaderId: json['uploader_id'],
      attachmentType: json['attachment_type'],
      fileUrl: json['file_url'],
      uploadedAt: DateTime.parse(json['uploaded_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'errand_id': errandId,
      'uploader_id': uploaderId,
      'attachment_type': attachmentType,
      'file_url': fileUrl,
      'uploaded_at': uploadedAt.toIso8601String(),
    };
  }
}
