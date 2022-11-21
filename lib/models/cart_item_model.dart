// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartItemModel {
  final String itemKey;
  final int id;
  final String name;
  final int quantity;
  final String featureImage;
  final double total;
  CartItemModel({
    required this.itemKey,
    required this.id,
    required this.name,
    required this.quantity,
    required this.featureImage,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemKey': itemKey,
      'id': id,
      'name': name,
      'quantity': quantity,
      'featureImage': featureImage,
      'total': total,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      itemKey: map['item_key'] as String,
      id: map['id'] as int,
      name: map['name'] as String,
      quantity: map['quantity']['value'] as int,
      featureImage: map['featured_image'] as String,
      total: map['totals']['total'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
