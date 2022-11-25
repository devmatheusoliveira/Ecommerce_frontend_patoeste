import 'package:badges/badges.dart';
import 'package:ecommerce/globals.dart';
import 'package:ecommerce/models/cart_item_model.dart';
import 'package:ecommerce/shared/theme/app_colors.dart';
import 'package:ecommerce/shared/widgets/cart_drawer/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  AppBarWidget({super.key, required this.scaffoldKey});

  List<CartItemModel> cartItems = [];

  final CartController cartController = CartController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 80,
      centerTitle: true,
      title: SizedBox(
        width: 200,
        child: TextFormField(
            decoration: const InputDecoration(label: Text("Pesquisar"))),
      ),
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Image.asset(
          "assets/images/logo.png",
          height: 100,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.search, color: AppColors.primary),
        ),
        IconButton(
          onPressed: () {
            // teste();

            scaffoldKey.currentState!.openEndDrawer();
          },
          icon: Observer(
            builder: (_) {
              return Badge(
                  showBadge: cartController.cartItens.isNotEmpty,
                  badgeContent: Text(
                    cartController.cartItens.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  child: const Icon(CupertinoIcons.cart,
                      color: AppColors.primary));
            },
          ),
        ),
        IconButton(
          onPressed: () => context.push('/login'),
          icon: const Icon(CupertinoIcons.person, color: AppColors.primary),
        ),
        const SizedBox(width: 40)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
