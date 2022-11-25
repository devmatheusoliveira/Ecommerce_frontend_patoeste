// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ecommerce/models/detail_product/dimensions_model.dart';
import 'package:ecommerce/models/detail_product/image_model.dart';

class DetailProductModel {
  int id;
  String name;
  String description;
  String price;
  List<ImageInfosModel> images;
  DimensionsModel dimensions;

  DetailProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.dimensions,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'images': images.map((x) => x.toMap()).toList(),
      'dimensions': dimensions.toMap(),
    };
  }

  factory DetailProductModel.fromMap(Map<String, dynamic> map) {
    List<ImageInfosModel> images = [];
    for (var element in map['images']) {
      images.add(ImageInfosModel.fromMap(element));
    }
    return DetailProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as String,
      images: images,
      dimensions:
          DimensionsModel.fromMap(map['dimensions'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailProductModel.fromJson(String source) =>
      DetailProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
