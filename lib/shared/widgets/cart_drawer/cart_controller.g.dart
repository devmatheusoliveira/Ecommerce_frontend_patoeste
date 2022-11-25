// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartController on CartBase, Store {
  late final _$cartItensAtom =
      Atom(name: 'CartBase.cartItens', context: context);

  @override
  List<CartItemModel> get cartItens {
    _$cartItensAtom.reportRead();
    return super.cartItens;
  }

  @override
  set cartItens(List<CartItemModel> value) {
    _$cartItensAtom.reportWrite(value, super.cartItens, () {
      super.cartItens = value;
    });
  }

  late final _$refreshCartAsyncAction =
      AsyncAction('CartBase.refreshCart', context: context);

  @override
  Future<void> refreshCart(Future<List<CartItemModel>> _cartItens) {
    return _$refreshCartAsyncAction.run(() => super.refreshCart(_cartItens));
  }

  @override
  String toString() {
    return '''
cartItens: ${cartItens}
    ''';
  }
}
