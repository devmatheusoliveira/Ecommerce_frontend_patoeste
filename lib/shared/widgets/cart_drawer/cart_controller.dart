import 'package:ecommerce/api/api_services.dart';
import 'package:ecommerce/models/cart_item_model.dart';
import 'package:mobx/mobx.dart';
part 'cart_controller.g.dart';

class CartController = CartBase with _$CartController;

abstract class CartBase with Store {
  APIService api = APIService();
  @observable
  List<CartItemModel> cartItens = [];

  @action
  Future<void> refreshCart(Future<List<CartItemModel>> _cartItens) async {
    cartItens = await _cartItens;
    print(cartItens);
  }
}
