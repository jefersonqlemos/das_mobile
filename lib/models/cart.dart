class Cart{
  late final int? id;
  late final int? client_id;
  late final String? total_value;
  late final String? name;
  late final String? last_name;
  late final String? cpf;

  Cart({
      required this.id,
      required this.client_id,
      required this.total_value,
      required this.name,
      required this.last_name,
      required this.cpf
  });

  Cart.fromJson(Map<dynamic, dynamic> data)
      : id = data['id'],
        client_id = data['client_id'],
        total_value = data['total_value'],
        name = data['name'],
        last_name = data['last_name'],
        cpf = data['cpf'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': client_id,
      'total_value': total_value,
      'name': name,
      'last_name': last_name,
      'cpf': cpf
    };
  }
}