import 'package:flutter/material.dart';

import 'Driver Signup Page.dart';
import 'Forgot password.dart';
import 'main.dart' hide ForgotPasswordPage, DriverSignUpPage, DriverSignupPage;

class DriverLoginPage extends StatefulWidget {
  @override
  _DriverLoginPageState createState() => _DriverLoginPageState();
}

class _DriverLoginPageState extends State<DriverLoginPage> {
  final TextEditingController _driverIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Driver login successful!')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8), // Light background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 120),

                Icon(Icons.directions_bus_filled_outlined,
                    size: 98, color: Color(0xFF1E88E5)), // Blue icon

                const SizedBox(height: 10),

                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'BusTrack',
                        style: TextStyle(
                          fontSize: 28,
                          color: Color(0xFF212121), // Dark text
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Pro',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFF1E88E5), // Blue highlight
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // Driver ID
                TextFormField(
                  controller: _driverIDController,
                  decoration: InputDecoration(
                    hintText: 'Driver ID',
                    prefixIcon: Icon(Icons.person, color: Color(0xFF1565C0)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter your Driver ID' : null,
                ),

                const SizedBox(height: 20),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF1565C0)),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) =>
                  value == null || value.length < 6 ? 'Password must be at least 6 characters' : null,
                ),

                // Remember & Forgot
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                        const Text('Remember Me'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ForgotPasswordPage()),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Color(0xFF00ACC1)), // Cyan accent
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Create Account
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DriverSignupPage()),
                    );
                  },
                  child: const Text(
                    "Create New Account",
                    style: TextStyle(
                      color: Color(0xFF1565C0), // Deep blue
                      fontSize: 20,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E88E5), // Primary Blue
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'Login',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
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

