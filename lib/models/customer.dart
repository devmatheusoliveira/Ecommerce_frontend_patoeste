// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CustomerModel {
  String email;
  String first_name;
  String last_name;
  String password;
  CustomerModel({
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.password,
  });

  CustomerModel copyWith({
    String? email,
    String? first_name,
    String? last_name,
    String? password,
  }) {
    return CustomerModel(
      email: email ?? this.email,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'password': password,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      email: map['email'] as String,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerModel(email: $email, first_name: $first_name, last_name: $last_name, password: $password)';
  }

  @override
  bool operator ==(covariant CustomerModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.first_name == first_name &&
        other.last_name == last_name &&
        other.password == password;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        first_name.hashCode ^
        last_name.hashCode ^
        password.hashCode;
  }
}
