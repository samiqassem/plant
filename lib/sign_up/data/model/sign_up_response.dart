class SignUpResponse {
  final int statusCode;
  final String message;
  final String? token; // حقل التوكن

  SignUpResponse({
    required this.statusCode,
    required this.message,
    this.token,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      statusCode: json['statusCode'] ?? 201,
      message: json['message'] ?? 'User registered successfully.',
      token: json['token'], // التوكن لو السيرفر بيرجعه
    );
  }

  factory SignUpResponse.fromStatusCode(int code) {
    switch (code) {
      case 201:
        return SignUpResponse(
          statusCode: 201,
          message: "User registered successfully.",
          token: null,
        );
      case 400:
        return SignUpResponse(
          statusCode: 400,
          message: "Missing required fields.",
        );
      case 409:
        return SignUpResponse(
          statusCode: 409,
          message: "Username, email, or phone number already exists.",
        );
      case 500:
        return SignUpResponse(
          statusCode: 500,
          message: "Server error. Please try again later.",
        );
      default:
        return SignUpResponse(
          statusCode: code,
          message: "Unknown error occurred.",
        );
    }
  }
}
