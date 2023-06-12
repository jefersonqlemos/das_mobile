import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/client.dart';

class ClientService {
  static const String apiUrl = 'http://localhost:3000/clients';

  Future<List<Client>?> getAll() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => parse(item)).toList();
      } else {
        throw Exception('Failed to load clients');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<int> getMaxId() async {
    try {
      const url = '$apiUrl?_sort=id&_order=desc&_page=1&_limit=1';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        var maxItem = jsonData.map((item) => parse(item)).toList().first;
        return maxItem.id! + 1;
      } else {
        throw Exception('Failed to load clients');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Client parse(dynamic jsonData) {
    try {
      return Client.fromJson(jsonData);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Client> getById(String id) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$id'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return parse(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('Client not found');
      } else {
        throw Exception('Failed to fetch client');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> add(Client client) async {
    try {
      final jsonBody = json.encode(client.toJson());
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to add client');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> edit(Client client) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/${client.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(client.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to edit the client');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> delete(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete client');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
