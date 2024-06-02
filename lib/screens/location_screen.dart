import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Location',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const LocationForm(),
    );
  }
}

class LocationForm extends StatefulWidget {
  const LocationForm({super.key});

  @override
  _LocationFormState createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  late String _selectedCity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: double.infinity,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a city name';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: 'Enter city name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String city = _controller.text;
                  Navigator.pushNamed(context, '/weather', arguments: city);
                }
              },
              child: const Text('Get Weather'),
            ),
          ],
        ),
      ),
    );
  }
}
