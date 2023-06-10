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
        title: const Text('Clients'),
      ),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (BuildContext context, int index) {
          final client = clients[index];
          return Card(
            child: ListTile(
              title: Text(client.name),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() async {
                    await clientService.delete(client.id!);
                    List<Client> fetchedData = (await clientService.getAll())!;
                    clients = fetchedData;
                  });
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditClientScreen(client: client),
                  ),
                ).then((updatedClient) {
                  if (updatedClient != null) {
                    setState(() async {
                      await clientService.edit(updatedClient);
                      loadData();
                    });
                  }
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddClientScreen()),
          ).then((added) {
            if (added != null) {
              setState(() async {
                final int maxId = await clientService.getMaxId();
                var addedClient = added as Client;
                var addClient = Client(id: maxId, name: addedClient.name);
                await clientService.add(addClient);
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

class AddClientScreen extends StatefulWidget {
  @override
  _AddClientScreenState createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Client'),
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

class EditClientScreen extends StatefulWidget {
  final Client client;

  const EditClientScreen({required this.client});

  @override
  _EditClientScreenState createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.client.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Client'),
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
                      final updatedClient = Client(
                        id: widget.client.id,
                        name: _nameController.text,
                      );
                      Navigator.pop(context, updatedClient);
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
