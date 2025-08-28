import 'package:flutter/material.dart';
import 'Student home Page.dart';
import 'api_service.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> loginStudent(String studentid, String password) async {
  final url = Uri.parse('http://172.16.127.231:9090/login'); // backend IP

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'studentid': studentid,  //  use correct field
      'password': password,
    }),
  );

  if (response.statusCode == 200) {   //  login should return 200
    print('Login success: ${response.body}');
  } else {
    print('Login failed: ${response.statusCode} - ${response.body}');
  }
}


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomePage(),
  ));
}



class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF1F7), // Light background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 2),

              // Bus Icon
              Icon(Icons.directions_bus_filled, size: 100, color: Color(0xFF3E64FF)),


              SizedBox(height: 24),

              // Title
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'BusTrack',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: 'Pro',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00C9A7), // Teal
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),

              // User Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3E64FF), // Blue
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Student Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Driver Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DriverLoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00C9A7), // Teal
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Driver Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

//--------------------User Login Page-------------------------



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

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String userId = _StudentIDController.text.trim();
      String password = _passwordController.text;

      ;Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _isLoading = false;
            });

            if (userId == 'hi' && password == 'hi123456') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => StudentHomePage(
                    studentName: 'Vishwa v.',
                    studentId: 'hi',
                    phoneNumber: '9876543210',
                    stopName: 'Noothanchari',
                    routeNumber: '4',
                    collegeName: 'SriSaiRam College',
                  ),
                ),
              );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid User ID or Password')),
          );
        }
      });
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
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPasswordPage())),
                      child: Text("Forgot Password?", style: TextStyle(color: Color(0xFF3E64FF))),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CreateAccountPage())),
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



// ------------------- Driver Login Page -------------------

class DriverLoginPage extends StatefulWidget {
  @override
  _DriverLoginPageState createState() => _DriverLoginPageState();
}

class _DriverLoginPageState extends State<DriverLoginPage> {
  final TextEditingController _driverIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Driver login successful!')),
        );
        // TODO: Navigate to DriverHomePage
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Icon(Icons.directions_bus_filled_outlined, size: 100, color: Colors.brown.shade400),
                  SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'BusTrack',
                          style: TextStyle(fontSize: 28, color: Colors.brown.shade700, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Pro',
                          style: TextStyle(fontSize: 32, color: Colors.yellow.shade800, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),

                  // Driver ID
                  _buildTextField(
                    controller: _driverIDController,
                    hint: 'Driver ID',
                    icon: Icons.person_outline,
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Enter Driver ID' : null,
                  ),
                  SizedBox(height: 20),

                  // Password
                  _buildTextField(
                    controller: _passwordController,
                    hint: 'Password',
                    icon: Icons.lock_outline,
                    obscure: _obscurePassword,
                    suffix: IconButton(
                      icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    validator: (value) =>
                    value != null && value.length < 6 ? 'Min 6 characters' : null,
                  ),
                  SizedBox(height: 10),

                  // Remember Me and Forgot
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (val) => setState(() => _rememberMe = val!),
                      ),
                      Text('Remember Me', style: TextStyle(color: Colors.brown.shade700)),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPasswordPage()));
                        },
                        child: Text("Forgot Password?", style: TextStyle(color: Colors.yellow.shade800)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade700,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Login', style: TextStyle(fontSize: 18, color: Colors.black)),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Create Account
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DriverSignupPage()));
                    },
                    child: Text(
                      "Create New Account",
                      style: TextStyle(color: Colors.brown.shade800, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    Widget? suffix,
    bool obscure = false,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.brown.shade400),
        suffixIcon: suffix,
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}



// ----------------------- FORGOT PASSWORD PAGE -------------------------




class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitResetRequest() {
    if (_formKey.currentState!.validate()) {
      final method = _tabController.index == 0 ? "Email" : "Phone";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset link/OTP sent via $method!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF1F7), // Blue-gray background
      appBar: AppBar(
        backgroundColor: Color(0xFF3E64FF), // Cool blue
        title: const Text('Forgot Password', style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Email'),
            Tab(text: 'Phone'),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildTabContent(
              hintText: "Enter your email",
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || !value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            _buildTabContent(
              hintText: "Enter your phone number",
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.length != 10) {
                  return 'Please enter a valid 10-digit phone number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent({
    required String hintText,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 60),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(color: Color(0xFF1A1A1A)),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF707070)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF3E64FF), width: 2),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            validator: validator,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitResetRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00C9A7), // Teal green
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
              child: const Text('Send Reset Link or OTP', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------User SIGN UP PAGE ------------------------



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




// -----------------Driver Signup Page-----------------


class DriverSignupPage extends StatefulWidget {
  @override
  _DriverSignupPageState createState() => _DriverSignupPageState();
}

class _DriverSignupPageState extends State<DriverSignupPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController driverIdController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade600,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        title: Text("Driver Signup", style: TextStyle(color: Colors.brown.shade800)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown.shade800),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField(nameController, "Name", Icons.person),
              buildTextField(driverIdController, "Driver ID", Icons.badge),
              buildTextField(phoneController, "Phone Number", Icons.phone),
              buildTextField(passwordController, "Password", Icons.lock, obscure: true),
              SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade700,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform signup logic
                    print("Driver account created!");
                  }
                },
                child: Text(
                  "Create Account",
                  style: TextStyle(color: Colors.brown.shade800, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, IconData icon, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow),
          )
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}

//----------------Student Home Page-----------------------


