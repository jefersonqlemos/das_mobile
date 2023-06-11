import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/cart-product.dart';
import '../repositories/cart-repository.dart';

class CartProductsList extends StatefulWidget {

  final String cart_id;

  CartProductsList({required this.cart_id});

  @override
  _MyAppState createState() => _MyAppState(cart_id);

}

class _MyAppState extends State {
  var cartProducts = <CartProduct>[];

  String cart_id = '';

  _MyAppState(String cart_id){
    this.cart_id = cart_id;
  }

  _getCartProducts() {
    CartRepository.getCartProducts(this.cart_id).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        cartProducts = list.map((model) => CartProduct.fromJson(model)).toList();
      });
    });
  }

  _updateCartProduct(String id, int index) {

  }

  @override
  initState() {
    super.initState();
    _getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Produtos do Carrinho';
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
          itemCount: cartProducts.length,
          itemBuilder: (context, index) {
            final item = cartProducts[index];
            return ListTile(
                title: Text(item.name.toString()),
                subtitle: Text("Valor unitário: RS "+item.value.toString()), //+ NumberFormat("###.00", "en_US").format(int.parse(item.value.toString()))),
                trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        width: 100,
                        child: TextField(
                          controller: TextEditingController()..text = item.quantity.toString(),
                          maxLength: 3,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "0",
                              counterText: "",
                              suffixIcon: IconButton(
                                  icon:Icon(Icons.refresh),
                                  onPressed: () {
                                    _updateCartProduct(item.id.toString(), index);
                                  }
                              )
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      IconButton(
                          icon:Icon(Icons.delete),
                          onPressed: () {
                            //_deleteCart(item.id.toString(), index);
                          }
                      )
                    ])
            );
          }
      ),
    );
  }
}