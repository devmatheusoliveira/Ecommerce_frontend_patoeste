import 'dart:math';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/api/api_services.dart';
import 'package:ecommerce/globals.dart';
import 'package:ecommerce/shared/widgets/appbar/app_bar_widget.dart';

import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/pages/home/cart_drawer/cart_drawer.dart';
import 'package:ecommerce/pages/home/home_controller.dart';
import 'package:ecommerce/shared/theme/app_colors.dart';
import 'package:ecommerce/shared/widgets/cart_drawer/cart_controller.dart';
import 'package:ecommerce/shared/widgets/product_itens_loja.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/cart_item_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final CarouselController controller = CarouselController();
  List<ProdutoModel> itens = [];
  List<CartItemModel> cartItems = [];

  List<ProdutoModel> itensSchneider = [];

  final cartController = CartController();
  @override
  void initState() {
    super.initState();
    APIService().initCart();
    Global.cartController.refreshCart(APIService().getCart());
  }

  Future<void> getItens() async {
    itens = await HomePageController().getProdutos();

    itens.forEach((element) {
      if (element.category == "Schneider Electric") itensSchneider.add(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    double larguraDaTela = MediaQuery.of(context).size.width;
    print(larguraDaTela);
    return Scaffold(
        key: scaffoldKey,
        endDrawer: Observer(builder: (_) {
          return CartDrawer(itens: Global.cartController.cartItens);
        }),
        appBar: AppBar(
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
                      showBadge: Global.cartController.cartItens.isNotEmpty,
                      badgeContent: Text(
                        Global.cartController.cartItens.length.toString(),
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
        ),
        body: FutureBuilder<List<ProdutoModel>>(
          future: HomePageController().getProdutos(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            itens = snapshot.data!;

            itens.forEach((element) {
              if (element.category == "Schneider Electric")
                itensSchneider.add(element);
            });
            return ListView(
              shrinkWrap: true,
              children: [
                CarouselSlider(
                  carouselController: controller,
                  options: CarouselOptions(
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    height: MediaQuery.of(context).size.height * 0.9,
                    autoPlay: false,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                  ),
                  items: [1, 2, 3].map((i) {
                    return Stack(
                      children: [
                        Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration:
                                  const BoxDecoration(color: Colors.red),
                              child: Image.asset(
                                "assets/images/$i.png",
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.9,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () => controller.previousPage(),
                                  icon: const Icon(CupertinoIcons.left_chevron,
                                      color: Colors.white, size: 50),
                                ),
                                IconButton(
                                  onPressed: () => controller.nextPage(),
                                  icon: const Icon(CupertinoIcons.right_chevron,
                                      color: Colors.white, size: 50),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: const Color(0xff3CCC64),
                                height: 120,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Confira nossas \nPROMO????ES",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                Container(
                  color: const Color(0xff3CCC64),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/schneider.png",
                    height: 100,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: larguraDaTela >= 1300
                          ? (larguraDaTela - 1300) / 2
                          : 100),
                  child: SizedBox(
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: 500,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          autoPlay: false,
                          viewportFraction: 0.40,
                          enableInfiniteScroll: true,
                          onPageChanged: (index, _) {}),
                      items: itensSchneider.map((produto) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ProdutoLojaWidget(
                              produto: produto,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: larguraDaTela >= 1300
                          ? (larguraDaTela - 1300) / 2
                          : 100),
                  child: Row(
                    children: [
                      Image.asset("assets/images/logo_icone.PNG", width: 30),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Produtos',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: larguraDaTela >= 1300
                          ? (larguraDaTela - 1300) / 2
                          : 50),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: max(1000, 100),
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      runSpacing: 20,
                      children: itens.map((produto) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ProdutoLojaWidget(
                              produto: produto,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                //---------------------------footer-----------------------------//

                Image.asset(
                  "assets/images/logo.png",
                  height: 75,
                ),
                const SizedBox(height: 10),
                const SelectableText(
                  "Refer??ncia no Com??rcio de Materiais El??tricos, Instala????es El??tricas Industriais e Energia Solar Fotovoltaica",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 40,
                    children: [
                      Container(
                        width: 230,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SelectableText(
                              "Entre em contato",
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Icon(Icons.whatsapp, color: Colors.grey),
                                const SizedBox(width: 5),
                                SelectableText(
                                  "46 3220 5566",
                                  style: TextStyle(color: Colors.grey.shade600),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                SelectableText(
                                  "orcamentos2@patoeste.com.br",
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                SelectableText(
                                  "R. Tam??io, 355 - Centro\nPato Branco - PR, 85501-067",
                                  style: TextStyle(color: Colors.grey.shade600),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 225,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(
                              "Sobre N??s",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 10),
                            SelectableText(
                              "Politica de reembolso",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 20),
                            SelectableText(
                              "Minha conta",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 10),
                            SelectableText(
                              "Rastreamento",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 10),
                            SelectableText(
                              "Pedidos",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(
                              "Departamentos",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 10),
                            SelectableText(
                              "Produtos novos",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 10),
                            SelectableText(
                              "Mais vendidos",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 15),
                            const SelectableText(
                              "Nos siga",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(children: [
                              InkWell(
                                child: Image.asset(
                                  "assets/icons/facebook.png",
                                  height: 20,
                                ),
                                onTap: () {
                                  launchUrl(
                                    Uri.parse(
                                      "https://www.facebook.com/grupo.patoeste/",
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                child: Image.asset(
                                  "assets/icons/instagram.png",
                                  height: 20,
                                ),
                                onTap: () {
                                  launchUrl(
                                    Uri.parse(
                                      "https://www.instagram.com/grupo_patoeste/",
                                    ),
                                  );
                                },
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
                SizedBox(
                  height: 50,
                  child: Text(
                    "Direitos reservados ?? ${DateTime.now().year} Patoeste",
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          },
        ));
  }
}
