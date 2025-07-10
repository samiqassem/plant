class ProfileResponse {
  final User user;
  final SubscriptionInfo subscriptionInfo;

  ProfileResponse({
    required this.user,
    required this.subscriptionInfo,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      user: User.fromJson(json['user'] ?? {}),
      subscriptionInfo: SubscriptionInfo.fromJson(json['subscription_info'] ?? {}),
    );
  }
}

class User {
  final String id;
  final String username;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String profileImage;
  final String role;
  final Location location;
  final Subscription subscription;
  final bool twoFactorSecret;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.profileImage,
    required this.role,
    required this.location,
    required this.subscription,
    required this.twoFactorSecret,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      profileImage: json['profileImage']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      subscription: Subscription.fromJson(json['subscription'] ?? {}),
      twoFactorSecret: json['twoFactorSecret'] == true,
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Subscription {
  final String currentPlan;
  final String status;
  final Map<String, dynamic> features;

  Subscription({
    required this.currentPlan,
    required this.status,
    required this.features,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      currentPlan: json['currentPlan']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      features: json['features'] ?? {},
    );
  }
}

class SubscriptionInfo {
  final String plan;
  final int scanLimit;
  final int scansUsed;
  final int scansRemaining;
  final bool hasAdvancedAnalytics;
  final bool prioritySupport;
  final bool apiAccess;

  SubscriptionInfo({
    required this.plan,
    required this.scanLimit,
    required this.scansUsed,
    required this.scansRemaining,
    required this.hasAdvancedAnalytics,
    required this.prioritySupport,
    required this.apiAccess,
  });

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) {
    return SubscriptionInfo(
      plan: json['plan']?.toString() ?? '',
      scanLimit: json['scan_limit'] is int ? json['scan_limit'] : 0,
      scansUsed: json['scans_used'] is int ? json['scans_used'] : 0,
      scansRemaining: json['scans_remaining'] is int ? json['scans_remaining'] : 0,
      hasAdvancedAnalytics: json['has_advanced_analytics'] == true,
      prioritySupport: json['priority_support'] == true,
      apiAccess: json['api_access'] == true,
    );
  }
}
