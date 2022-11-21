// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginResponseModel {
  int? statuscode;
  String token;
  String user_email;
  String user_nicename;
  String user_display_name;
  LoginResponseModel({
    this.statuscode,
    required this.token,
    required this.user_email,
    required this.user_nicename,
    required this.user_display_name,
  });

  LoginResponseModel copyWith({
    int? statuscode,
    String? token,
    String? user_email,
    String? user_nicename,
    String? user_display_name,
  }) {
    return LoginResponseModel(
      statuscode: statuscode ?? this.statuscode,
      token: token ?? this.token,
      user_email: user_email ?? this.user_email,
      user_nicename: user_nicename ?? this.user_nicename,
      user_display_name: user_display_name ?? this.user_display_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statuscode': statuscode,
      'token': token,
      'user_email': user_email,
      'user_nicename': user_nicename,
      'user_display_name': user_display_name,
    };
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      statuscode: map['statuscode'] != null ? map['statuscode'] as int : null,
      token: map['token'] as String,
      user_email: map['user_email'] as String,
      user_nicename: map['user_nicename'] as String,
      user_display_name: map['user_display_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) =>
      LoginResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginResponseModel(statuscode: $statuscode, token: $token, user_email: $user_email, user_nicename: $user_nicename, user_display_name: $user_display_name)';
  }

  @override
  bool operator ==(covariant LoginResponseModel other) {
    if (identical(this, other)) return true;

    return other.statuscode == statuscode &&
        other.token == token &&
        other.user_email == user_email &&
        other.user_nicename == user_nicename &&
        other.user_display_name == user_display_name;
  }

  @override
  int get hashCode {
    return statuscode.hashCode ^
        token.hashCode ^
        user_email.hashCode ^
        user_nicename.hashCode ^
        user_display_name.hashCode;
  }
}
