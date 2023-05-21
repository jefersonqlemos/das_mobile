import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:das_mobile/models/cart.dart';
import 'package:das_mobile/repositories/cart-repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartList extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  // save in the state for caching!
  var carts = <Cart>[];

  _getCarts() {
    CartRepository.getCarts().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        carts = list.map((model) => Cart.fromJson(model)).toList();
      });
    });
  }

  _deleteCart(String id, int index){
    CartRepository.deleteCart(id).then((response) {
      setState(() {
        if(response.statusCode == 200){
          carts.remove(index);
          Fluttertoast.showToast(
              msg: response.body.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      });
    });
  }

  @override
  initState() {
    super.initState();
    _getCarts();
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Carrinhos';
    return Scaffold(
                appBar: AppBar(
                  title: const Text(title),
                ),
                body: ListView.builder(
                  // Let the ListView know how many items it needs to build.
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                    itemCount: carts.length,
                    itemBuilder: (context, index) {
                    final item = carts[index];
                    return ListTile(
                          title: Text(item.name.toString()),
                          subtitle: Text(NumberFormat("#,##0.00", "en_US").format(int.parse(item.total_value.toString()))),
                          trailing: IconButton(
                            icon:Icon(Icons.delete),
                            onPressed: () {
                              _deleteCart(item.id.toString(), index);
                            }
                          )
                        );
                  }
                  ),
    );
  }
}

