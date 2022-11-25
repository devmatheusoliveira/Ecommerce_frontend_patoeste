import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DimensionsModel {
  String height;
  String length;
  String width;

  DimensionsModel({
    required this.height,
    required this.length,
    required this.width,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'heigth': height,
      'length': length,
      'width': width,
    };
  }

  factory DimensionsModel.fromMap(Map<String, dynamic> map) {
    return DimensionsModel(
      height: map['height'] as String,
      length: map['length'] as String,
      width: map['width'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DimensionsModel.fromJson(String source) =>
      DimensionsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
