// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ecommerce/models/product_model.dart';

class ProdutoLojaWidget extends StatelessWidget {
  final ProdutoModel produto;
  const ProdutoLojaWidget({
    Key? key,
    required this.produto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Image.network(
                produto.image,
                width: 200,
                height: 200,
              ),
            ),
          ),
          Text(
            produto.name.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            height: 50,
            child: Text(
              produto.description
                  .replaceAll(RegExp(r'<p>'), "")
                  .replaceAll(RegExp(r'</p>'), ""),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text.rich(
            TextSpan(
              text: "R\$",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: produto.price.split('.')[0],
                  style: const TextStyle(fontSize: 40),
                ),
                TextSpan(
                  text: ",${produto.price.split('.')[1]}",
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              launchUrl(Uri.parse(produto.buyLink));
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.primary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            child: const Text("COMPRAR"),
          ),
        ],
      ),
    );
  }
}
