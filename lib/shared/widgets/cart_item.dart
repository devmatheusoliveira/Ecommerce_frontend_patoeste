import 'dart:html';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:ecommerce/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItem;
  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Image.network(cartItem.featureImage),
      title: Text(cartItem.name),
      subtitle: Text(UtilBrasilFields.obterReal(cartItem.total)),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.remove,
              ),
            ),
            Text(cartItem.quantity.toString()),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
