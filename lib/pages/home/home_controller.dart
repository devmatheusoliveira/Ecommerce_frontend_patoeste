import 'dart:convert';

import 'package:ecommerce/models/product_model.dart';
import 'package:http/http.dart' as http;

class HomePageController {
  Future<List<ProdutoModel>> getProdutos() async {
    List<ProdutoModel> produtos = [];
    final response = await http.get(
        Uri.parse('http://devmatheusoliveira.com.br/mypythonapp/ListProducts'));
    if (response.statusCode == 200) {
      for (var element in jsonDecode(response.body)) {
        if (element['date_created'] != null) {
          ProdutoModel produtoModel = ProdutoModel(
            name: element['name'] as String,
            description: element['short_description'] as String,
            image: element['images'].length >= 0
                ? element['images'][0]["src"] as String
                : " ",
            price: element['price'] as String,
            buyLink: element['permalink'] as String,
            category: element['categories'][0]["name"] as String,
          );
          // print(produtoModel);
          produtos.add(produtoModel);
        }
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return produtos;
  }
}
