import 'package:das_mobile/screens/client_screen.dart';
import 'package:das_mobile/screens/product_screen.dart';
import 'package:das_mobile/carrinho/cart-list.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                /*image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg')
                )*/
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.supervisor_account),
            title: const Text('Clientes'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClientScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text('Produtos'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                  MaterialPageRoute(builder: (context) => ProductScreen()),
              );
            },
          ),
          ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Carrinhos'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartList()),
                )
              }
          ),
          ListTile(
            leading: const Icon(Icons.inbox),
            title: const Text('Pedidos'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}