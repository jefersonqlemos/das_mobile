import 'dart:convert';
import 'dart:developer';
import 'package:das_mobile/models/cart.dart';
import '../services/requests.dart';

class CartRepository {
  /*static getCart() async {
    final response = await Requests.get('carts');
    return (json.decode(response.body) as List).map((i) => Cart.fromMap(i)).toList();
  }*/

  static Future getCarts() {
      return Requests.get('carts');
  }

  static Future getCartProducts(String id) {
    return Requests.get('carts/'+id);
  }

  static Future deleteCart(String id) {
    return Requests.delete('carts/'+id);
  }
}