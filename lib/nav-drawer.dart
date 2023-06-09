import 'dart:convert';

import 'package:das_mobile/carrinho/cart-list.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
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
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.supervisor_account),
            title: Text('Clientes'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.view_list),
            title: Text('Produtos'),
            onTap: () => {Navigator.of(context).pop()},
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
            leading: Icon(Icons.inbox),
            title: Text('Pedidos'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}