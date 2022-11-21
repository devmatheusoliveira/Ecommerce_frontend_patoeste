import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class ApiTeste {
  Future<void> testando() async {
    var dio = Dio();
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    (await dio.get('https://lojapatoeste.com.br/admin/wp-json/cocart/v2/cart'))
        .headers
        .forEach((name, values) {
      if (name == 'cocart-api-cart-key') print("$name ==> $values");
    });
    // Print cookies
    print(await cookieJar.loadForRequest(Uri.parse('https://baidu.com/')));
    // second request with the cookie
    await dio.get('https://baidu.com/');
  }
}
