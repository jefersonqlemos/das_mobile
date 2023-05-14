import 'package:das_mobile/models/cart.dart';
import 'package:das_mobile/repositories/cart-repository.dart';
import 'package:flutter/material.dart';


class CartList extends StatelessWidget {

  late List<Cart> list = CartRepository.getCart();

  @override
  Widget build(BuildContext context) {
    const title = 'Carrinhos';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = list[index];

            return ListTile(
              title: Text(item.name.toString()),
              subtitle: Text(item.total_value.toString()),
            );
          },
        ),
      ),
    );
  }
}

