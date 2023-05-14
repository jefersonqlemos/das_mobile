import 'dart:convert';
import 'package:das_mobile/models/cart.dart';
import '../services/requests.dart';

class CartRepository {
  static getCart() async {
    final response = await Requests.get('carts');
    return (json.decode(response.body) as List).map((i) => Cart.fromMap(i)).toList();
  }
}