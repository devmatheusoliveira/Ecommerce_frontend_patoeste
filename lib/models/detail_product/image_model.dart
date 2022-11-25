import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ImageInfosModel {
  String src;
  ImageInfosModel({
    required this.src,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'src': src,
    };
  }

  factory ImageInfosModel.fromMap(Map<String, dynamic> map) {
    return ImageInfosModel(
      src: map['src'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageInfosModel.fromJson(String source) =>
      ImageInfosModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
