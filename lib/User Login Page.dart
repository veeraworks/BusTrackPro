import 'package:flutter/material.dart';
import 'Forgot password.dart';
import 'Student home Page.dart';
import 'User Signup Page.dart';
import 'api_service.dart'; // our backend connection

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _StudentIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String userId = _StudentIDController.text.trim();
      String password = _passwordController.text;

      // call API
      final student = await ApiService.loginStudent(userId, password);

      setState(() {
        _isLoading = false;
      });

      if (student != null) {
        // ✅ Navigate to Home Page with student details
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => StudentHomePage(
              studentName: student["name"],
              studentId: student["studentId"],
              phoneNumber: student["phoneNumber"],
              stopName: student["stopName"],
              routeNumber: student["routeNumber"],
              collegeName: student["collegeName"],
            ),
          ),
        );
      } else {
        // ❌ show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid User ID or Password")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF1F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 80),
                Icon(Icons.directions_bus, size: 90, color: Color(0xFF3E64FF)),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'BusTrack',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFF1A1A1A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Pro',
                        style: TextStyle(
                          fontSize: 34,
                          color: Color(0xFF00C9A7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _StudentIDController,
                  decoration: InputDecoration(
                    hintText: 'Student ID',
                    hintStyle: TextStyle(color: Color(0xFF707070)),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Enter your User ID' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Color(0xFF707070)),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFF3E64FF),
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (value) => value == null || value.length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          activeColor: Color(0xFF00C9A7),
                          onChanged: (value) => setState(() => _rememberMe = value!),
                        ),
                        Text('Remember Me', style: TextStyle(color: Color(0xFF1A1A1A))),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => ForgotPasswordPage())),
                      child: Text("Forgot Password?", style: TextStyle(color: Color(0xFF3E64FF))),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => CreateAccountPage())),
                  child: Text(
                    "Create New Account",
                    style: TextStyle(color: Color(0xFF3E64FF), fontSize: 18),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00C9A7),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Login', style: TextStyle(fontSize: 18, color: Colors.white)),
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