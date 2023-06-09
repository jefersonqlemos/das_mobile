import 'package:flutter/material.dart';
import '../models/client.dart';
import '../services/client_service.dart';

class ClientScreen extends StatefulWidget {
  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  ClientService clientService = ClientService();
  List<Client> clients = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // Make an asynchronous API call or any other async operation
    List<Client> fetchedData = (await clientService.getAll())!;

    setState(() {
      // Update the state with the fetched data
      clients = fetchedData;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clients'),
      ),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (BuildContext context, int index) {
          final client = clients[index];
          return ListTile(
            title: Text(client.name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() async {
                  clientService.delete(client.id!);
                  List<Client> fetchedData = (await clientService.getAll())!;
                  clients = fetchedData;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add client screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddClientScreen()),
          ).then((addedClient) {
            if (addedClient != null) {
              setState(() async {
                final int maxId = await clientService.getMaxId();
                await clientService.add(Client(id: maxId, name: addedClient['name']));
                List<Client> fetchedData = (await clientService.getAll())!;
                clients = fetchedData;
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddClientScreen extends StatefulWidget {
  @override
  _AddClientScreenState createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _valueController = TextEditingController();

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
        title: Text('Add Client'),
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
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the client name';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newClient = Client(
                        name: _nameController.text,
                      );
                      Navigator.pop(context, newClient);
                    }
                  },
                  child: Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

