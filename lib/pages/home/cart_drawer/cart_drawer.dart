// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/models/cart_item_model.dart';
import 'package:ecommerce/shared/widgets/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/shared/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartDrawer extends StatefulWidget {
  List<CartItemModel> itens;
  CartDrawer({
    Key? key,
    required this.itens,
  }) : super(key: key);

  @override
  State<CartDrawer> createState() => _CartDrawerState();
}

class _CartDrawerState extends State<CartDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Carrinhos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.clear,
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: widget.itens.length,
                itemBuilder: (context, index) {
                  return CartItemWidget(cartItem: widget.itens[index]);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.maxFinite, 50),
                  backgroundColor: AppColors.secondary,
                  padding: const EdgeInsets.all(0),
                ),
                child: const Text(
                  'Finalizar e ir para pagamento',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.remove("cocart-api-cart-key");
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
