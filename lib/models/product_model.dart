// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';

class ProdutoModel {
  String name;
  int id;
  String description;
  String image;
  String price;
  String buyLink;
  String category;
  ProdutoModel({
    required this.name,
    required this.id,
    required this.description,
    required this.image,
    required this.price,
    required this.buyLink,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'description': description,
      'image': image,
      'price': price,
      'buyLink': buyLink,
      'category': category,
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      name: map['name'] as String,
      id: map['id'] as int,
      description: map['description'] as String,
      image: map['image'] as String,
      price: map['price'] as String,
      buyLink: map['buyLink'] as String,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(String source) =>
      ProdutoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ProdutoModel copyWith({
    String? name,
    int? id,
    String? description,
    String? image,
    String? price,
    String? buyLink,
    String? category,
  }) {
    return ProdutoModel(
      name: name ?? this.name,
      id: id ?? this.id,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      buyLink: buyLink ?? this.buyLink,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    return 'ProdutoModel(name: $name, id: $id, description: $description, image: $image, price: $price, buyLink: $buyLink, category: $category)';
  }

  @override
  bool operator ==(covariant ProdutoModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        other.description == description &&
        other.image == image &&
        other.price == price &&
        other.buyLink == buyLink &&
        other.category == category;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        description.hashCode ^
        image.hashCode ^
        price.hashCode ^
        buyLink.hashCode ^
        category.hashCode;
  }
}
