import 'package:ecommerce/models/detail_product/detail_product_model.dart';
import 'package:ecommerce/pages/home/home_page.dart';
import 'package:ecommerce/pages/login/login_page.dart';
import 'package:ecommerce/pages/product_details/product_details_page.dart';
import 'package:ecommerce/pages/register/register_page.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> _rootNavigatorKey =
        GlobalKey<NavigatorState>();

    final routers = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: '/detalhes',
          name: 'detalhes',
          builder: (BuildContext context, GoRouterState state) {
            return const ProductDetailsPage();
          },
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterPage();
          },
        ),
      ],
    );
    return MaterialApp.router(
      // routerDelegate: routers.routerDelegate,
      // routeInformationParser: routers.routeInformationParser,
      // // routeInformationProvider: routers.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: 'Loja Patoeste',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routerConfig: routers,
    );
  }
}
