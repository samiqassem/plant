import 'dart:io';

class SignUpRequest {
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final String? fullName;
  final double? latitude;
  final double? longitude;
  final File? profileImage;

  SignUpRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.fullName,
    this.latitude,
    this.longitude,
    this.profileImage,
  });

  // لو هنبعت كـ JSON
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };

    if (fullName != null) data['fullName'] = fullName;
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;

    return data;
  }

  // لو هنبعت كـ FormData (مثلاً مع صورة)
  Map<String, dynamic> toFormData() {
    final data = <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };

    if (fullName != null) data['fullName'] = fullName;
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;

    return data;
  }
}
