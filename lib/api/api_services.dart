import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/models/cart_item_model.dart';
import 'package:ecommerce/models/customer.dart';
import 'package:ecommerce/models/detail_product/detail_product_model.dart';
import 'package:ecommerce/models/login_model.dart';
import 'package:ecommerce/models/token_model.dart';
import 'package:ecommerce/shared/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  var dio = Dio();
  Future<bool> createCustomer(CustomerModel model) async {
    await http.post(
        Uri.parse(
            'https://lojapatoeste.com.br/admin/wp-json/wc/v3/customers?consumer_key=ck_21680b7d0aa14b978d69fc0e981d4791a67e2746&consumer_secret=cs_777a054cb343b9d4a08208c743eba00fd571c54a'),
        body: model.toJson(),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }).then(
      (value) {
        print(value.statusCode);
        if (value.statusCode == 200) {
          return true;
        }
      },
    );
    return false;
  }

  Future<bool> getUser(CustomerModel model) async {
    await http.post(
        Uri.parse(
            'https://lojapatoeste.com.br/admin/wp-json/wc/v3/customers?consumer_key=ck_21680b7d0aa14b978d69fc0e981d4791a67e2746&consumer_secret=cs_777a054cb343b9d4a08208c743eba00fd571c54a'),
        body: model.toJson(),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }).then(
      (value) {
        print(value.statusCode);
        if (value.statusCode == 200) {
          return true;
        }
      },
    );
    return false;
  }

  Future<LoginResponseModel> loginCustomer(
      String username, String password) async {
    late LoginResponseModel model;

    try {
      var response = await dio.post(
        Config.tokenURL,
        data: {
          "username": username,
          "password": password,
        },
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded "
        }),
      );
      if (response.statusCode == 200) {
        print(response.data);

        model = LoginResponseModel.fromJson(json.encode(response.data));
        print(TokenModel.fromMap(JwtDecoder.decode(model.token)).id);
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return model;
  }

  Future<List<CartItemModel>> getCart() async {
    List<CartItemModel> list = [];
    final prefs = await SharedPreferences.getInstance();

    String cartKey = prefs.getString('cocart-api-cart-key')!;
    final token = prefs.getString("user_token");

    try {
      var response = await dio.get(
        "https://lojapatoeste.com.br/admin/wp-json/cocart/v2/cart${cartKey != "" ? '?cart_key=$cartKey' : ''}",
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded ",
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        response.headers.forEach(
          (name, values) {
            if (name == 'cocart-api-cart-key') {
              print('== ESSES SÃO OS VALORES ==> $values');
            }
          },
        );

        for (var item in response.data['items']) {
          print("tentei add ${item}");
          list.add(CartItemModel.fromMap(item));
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return list;
  }

  Future<void> initCart() async {
    List<CartItemModel> list = [];
    final prefs = await SharedPreferences.getInstance();

    String? cartKey = prefs.getString('cocart-api-cart-key');

    if (cartKey != null) {
      print('nao sou nulo');
      return;
    }
    final token = prefs.getString("user_token");
    print('sou nulo');

    try {
      var response = await dio.get(
        "https://lojapatoeste.com.br/admin/wp-json/cocart/v2/cart",
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded ",
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        response.headers.forEach(
          (name, values) {
            if (name == 'cocart-api-cart-key') {
              print('== ESSES SÃO OS VALORES ==> $values');
              prefs.setString("cocart-api-cart-key", values[0]);
            }
          },
        );
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> addToCart(int id, int quantidade) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("user_token");
    String? cartKey = prefs.getString('cocart-api-cart-key');

    try {
      var response = await dio.post(
        "https://lojapatoeste.com.br/admin/wp-json/cocart/v2/cart/add-item/",
        // "https://lojapatoeste.com.br/admin/wp-json/cocart/v2/cart/add-item/${cartKey != "" || cartKey != null ? '?cart_key=$cartKey' : ''}",
        data: {
          "id": id.toString(),
          "quantity": quantidade.toString(),
        },
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded ",
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        response.headers.forEach(
          (name, values) {
            if (name == 'cocart-api-cart-key') {
              prefs.setString('cocart-api-cart-key', values[0]);
              print(values);
            }
          },
        );
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future getProductDetail() async {
    final prefs = await SharedPreferences.getInstance();
    int productId = prefs.getInt('product_id')!;

    try {
      var response = await dio.get(
        "https://devmatheusoliveira.com.br/mypythonapp/products/$productId",
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded ",
          },
        ),
      );

      if (response.statusCode == 200) {
        prefs.setString('detail_product',
            DetailProductModel.fromMap(response.data).toJson());
        return DetailProductModel.fromMap(response.data);
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }
}
