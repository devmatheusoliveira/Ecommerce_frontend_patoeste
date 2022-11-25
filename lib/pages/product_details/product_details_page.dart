import 'package:ecommerce/api/api_services.dart';
import 'package:ecommerce/globals.dart';
import 'package:ecommerce/shared/widgets/appbar/app_bar_widget.dart';
import 'package:ecommerce/models/detail_product/detail_product_model.dart';
import 'package:ecommerce/pages/home/home_page.dart';
import 'package:ecommerce/shared/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final ScrollController scrollControllerVertical = ScrollController();
  final ScrollController scrollControllerHorizontal = ScrollController();

  String price = "10.00";
  int itemsAmount = 1;
  List<int> itemsQuantity = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25
  ];

  List<bool> isHoved = [false, false, false, false, false];
  List<String> imagens = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(scaffoldKey: _scaffoldKey),
      endDrawer: Drawer(width: 600),
      body: FutureBuilder(
          future: APIService().getProductDetail(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            DetailProductModel detailProduct =
                snapshot.data! as DetailProductModel;
            imagens.clear();
            for (var image in detailProduct.images) {
              imagens.add(image.src);
            }
            return Center(
              child: Scrollbar(
                isAlwaysShown: true,
                controller: scrollControllerHorizontal,
                child: SingleChildScrollView(
                  controller: scrollControllerHorizontal,
                  scrollDirection: Axis.horizontal,
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: scrollControllerVertical,
                    child: SingleChildScrollView(
                      controller: scrollControllerVertical,
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 100),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ImagesInfosWidget(listaDeImagens: imagens),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detailProduct.name,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'DISJUNTOR TERMOMAGNÉTICO TESYS GV2, 3P, 20 A 25A ATÉ 690V, 50/60HZ BOTÃO DE IMPULSÃO GV2ME22',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                    Text.rich(
                                      TextSpan(
                                        text: "R\$",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: detailProduct.price
                                                .split('.')[0],
                                            style:
                                                const TextStyle(fontSize: 40),
                                          ),
                                          TextSpan(
                                            text:
                                                ",${detailProduct.price.split('.')[1]}",
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      width: 180,
                                      child: ListTile(
                                          title: const Text("Quantidade"),
                                          trailing: StatefulBuilder(
                                            builder: (context, setState) {
                                              return DropdownButton<int>(
                                                value: itemsAmount,
                                                icon: const Icon(
                                                  CupertinoIcons.chevron_down,
                                                  color: AppColors.secondary,
                                                ),
                                                elevation: 16,
                                                underline: Container(
                                                  height: 2,
                                                  color: AppColors.secondary,
                                                ),
                                                onChanged: (int? value) {
                                                  // This is called when the user selects an item.
                                                  setState(() {
                                                    itemsAmount = value!;
                                                  });
                                                },
                                                items: itemsQuantity
                                                    .map<DropdownMenuItem<int>>(
                                                        (int value) {
                                                  return DropdownMenuItem<int>(
                                                    value: value,
                                                    child:
                                                        Text(value.toString()),
                                                  );
                                                }).toList(),
                                              );
                                            },
                                          )),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        print(itemsAmount);
                                        await APIService().addToCart(
                                            detailProduct.id, itemsAmount);
                                        await Global.cartController.refreshCart(
                                            APIService().getCart());
                                        context.pop();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Colors.green,
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                      ),
                                      child:
                                          const Text("Adicionar ao carrinho"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 100),
                          // SizedBox(
                          //   width: 600,
                          //   child: AdjustedHtmlView(
                          //     htmlText: htmlStr,
                          //   ),
                          // ),
                          const SizedBox(height: 100),
                          SizedBox(
                            height: 50,
                            child: Text(
                              "Direitos reservados © ${DateTime.now().year} Patoeste",
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class ImagesInfosWidget extends StatefulWidget {
  final List<String> listaDeImagens;
  const ImagesInfosWidget({
    Key? key,
    required this.listaDeImagens,
  }) : super(key: key);

  @override
  State<ImagesInfosWidget> createState() => _ImagesInfosWidgetState();
}

class _ImagesInfosWidgetState extends State<ImagesInfosWidget> {
  List<bool> isHoved = [];
  String imageSelecionada =
      "https://m.media-amazon.com/images/I/61lVriPAICL._AC_SX679_.jpg";
  @override
  void initState() {
    for (var i = 0; i < widget.listaDeImagens.length; i++) {
      isHoved.add(false);
    }
    imageSelecionada = widget.listaDeImagens.first;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: Row(
        children: [
          const SizedBox(width: 10),
          SizedBox(
            width: 65,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.listaDeImagens.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        imageSelecionada = widget.listaDeImagens[index];
                        isHoved[index] = true;
                      });
                    },
                    onHover: (value) {
                      setState(() {
                        imageSelecionada = widget.listaDeImagens[index];
                        isHoved[index] = value;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: isHoved[index]
                                ? AppColors.primary
                                : Colors.black,
                            width: isHoved[index] ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          widget.listaDeImagens[index],
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Container(
            color: Colors.white,
            height: 450,
            width: 450,
            child: Image.network(imageSelecionada),
          ),
        ],
      ),
    );
  }
}
