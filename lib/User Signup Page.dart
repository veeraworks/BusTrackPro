import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final studentIdController = TextEditingController();
  final collegeController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final routeNumberController = TextEditingController();
  final stopNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords do not match")),
        );
        return;
      }

      // Success logic (e.g., save account)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account Created Successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF1F7), // Light blue-gray
      appBar: AppBar(
        title: Text('Create New Account', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF3E64FF), // Cool blue
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildField(nameController, "Name"),
              buildField(studentIdController, "Student ID"),
              buildField(collegeController, "College Name"),
              buildField(phoneController, "Phone Number", type: TextInputType.phone),
              buildField(addressController, "Address", lines: 2),
              buildField(routeNumberController, "Route Number"),
              buildField(stopNameController, "Stop Name"),
              buildField(passwordController, "Password", obscure: true),
              buildField(confirmPasswordController, "Confirm Password", obscure: true),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00C9A7), // Teal green
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Create Account', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(
      TextEditingController controller,
      String label, {
        TextInputType type = TextInputType.text,
        bool obscure = false,
        int lines = 1,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: obscure,
        maxLines: lines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xFF1A1A1A)), // Dark label
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF3E64FF)), // Blue focus border
          ),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) => value == null || value.isEmpty ? "Please enter $label" : null,
      ),
    );
  }
}
