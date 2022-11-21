// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TokenModel {
  String id;
  TokenModel({
    required this.id,
  });

  TokenModel copyWith({
    String? id,
  }) {
    return TokenModel(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      id: map['data']['user']['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromJson(String source) =>
      TokenModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TokenModel(id: $id)';

  @override
  bool operator ==(covariant TokenModel other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
