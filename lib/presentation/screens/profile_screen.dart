import 'package:flutter/material.dart';
import 'package:gym_builder_app/presentation/widgets/drawer.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, required this.title});
  String title;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  // Define the initial values for the text fields
  final Map<String, String> _initialValues = {
    'First Name': 'first name',
    'Last Name': 'last name',
    'Email': 'email',
    'Password': 'password',
    'Address Line 1': 'address line 1',
    'Address Line 2': 'address line 2',
    'City': 'city',
    'Country': 'country',
    'Postal Code': 'postal code',
    'Phone Number': 'phone number',
  };

  // Define a function to validate the input
  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  // Define a function to save the form data
  void _saveForm() {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: const Color(0xff2b2b2b),
      ),
      drawer: appDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Loop through the initial values map and create a TextFormField for each key-value pair
                for (var entry in _initialValues.entries)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      initialValue: entry.value,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: entry.key,
                      ),
                      validator: _validateInput,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: _saveForm,
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
