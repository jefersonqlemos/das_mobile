class CartProduct{
  late final int? id;
  late final int? cart_id;
  late final int? quantity;
  late final int? product_id;
  late final String? value;
  late final String? name;

  CartProduct({
    required this.id,
    required this.cart_id,
    required this.quantity,
    required this.product_id,
    required this.value,
    required this.name
  });

  CartProduct.fromJson(Map<dynamic, dynamic> data)
      : id = data['id'],
        cart_id = data['cart_id'],
        quantity = data['quantity'],
        product_id = data['product_id'],
        value = data['value'],
        name = data['name'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart_id': cart_id,
      'quantity': quantity,
      'product_id': product_id,
      'value': value,
      'name': name
    };
  }
}