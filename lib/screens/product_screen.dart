import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductService productService = ProductService();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // Make an asynchronous API call or any other async operation
    List<Product> fetchedData = (await productService.getAll())!;

    setState(() {
      // Update the state with the fetched data
      products = fetchedData;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('Value: \$${product.value.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() async {
                  productService.delete(product.id!);
                  loadData();
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add product screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          ).then((added) {
            if (added != null) {
              setState(() async {
                final int maxId = await productService.getMaxId();
                var addedProduct = added as Product;
                var addProduct = Product(id:maxId, name: addedProduct.name, value: addedProduct.value);
                await productService.add(addProduct);
                loadData();
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(labelText: 'Value'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the product value';
                  }
                  if (double.tryParse(value!) == null) {
                    return 'Please enter a valid value';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newProduct = Product(
                        name: _nameController.text,
                        value: double.parse(_valueController.text),
                      );
                      Navigator.pop(context, newProduct);
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
