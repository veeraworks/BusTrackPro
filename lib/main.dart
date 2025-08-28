import 'package:flutter/material.dart';
import 'Student home Page.dart';
import 'api_service.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<void> loginStudent(String studentid, String password) async {
  final url = Uri.parse('http://10.68.187.121:9090/login'); // backend IP

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
              Icon(Icons.directions_bus_outlined, size: 100, color: Color(0xFF3E64FF)),


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
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  // 🔹 Replace with your backend URL
  final Uri url = Uri.parse("http://172.16.127.239:9090/login");

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'studentId': _studentIdController.text.trim(),
            'password': _passwordController.text.trim(),
          }),
        );

        setState(() => _isLoading = false);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => StudentHomePage(
                studentName: data['name'],
                studentId: data['studentId'],
                phoneNumber: data['phoneNumber'],
                stopName: data['stopName'],
                routeNumber: data['routeNumber'],
                collegeName: data['collegeName'],
              ),
            ),
          );
        } else if (response.statusCode == 401) {
          // Unauthorized (wrong password)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid User ID or Password')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Server Error: ${response.statusCode}')),
          );
        }
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to connect to server')),
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
                Icon(Icons.person, size: 90, color: Color(0xFF3E64FF)),
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
                  controller: _studentIdController,
                  decoration: InputDecoration(
                    hintText: 'Student ID',
                    hintStyle: TextStyle(color: Color(0xFF707070)),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Enter your User ID' : null,
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
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Color(0xFF3E64FF),
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (value) =>
                  value == null || value.length < 6
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
                          onChanged: (value) =>
                              setState(() => _rememberMe = value!),
                        ),
                        Text('Remember Me',
                            style: TextStyle(color: Color(0xFF1A1A1A))),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ForgotPasswordPage())),
                      child: Text("Forgot Password?",
                          style: TextStyle(color: Color(0xFF3E64FF))),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CreateAccountPage())),
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Login',
                        style:
                        TextStyle(fontSize: 18, color: Colors.white)),
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




// -----------------Driver Signup Page-------------------------



class DriverSignupPage extends StatefulWidget {
  @override
  _DriverSignupPageState createState() => _DriverSignupPageState();
}

class _DriverSignupPageState extends State<DriverSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _driverIdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // Light Blue-Gray
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0), // Deep Blue
        title: const Text(
          "Driver Signup",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                //  Bus Icon at the top
                Center(
                  child: Icon(
                    Icons.directions_bus,
                    size: 100,
                    color: Color(0xFF1565C0), // Deep Blue same as AppBar
                  ),
                ),
                const SizedBox(height: 24),

                _buildTextField(
                  controller: _nameController,
                  icon: Icons.person,
                  label: "Name",
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _driverIdController,
                  icon: Icons.badge,
                  label: "Driver ID",
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _phoneController,
                  icon: Icons.phone,
                  label: "Phone Number",
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _passwordController,
                  icon: Icons.lock,
                  label: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                //  Confirm Password Field
                _buildTextField(
                  controller: _confirmPasswordController,
                  icon: Icons.lock_outline,
                  label: "Confirm Password",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm Password cannot be empty";
                    }
                    if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Gradient Button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF00C9A7), // Solid Driver Green
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // let Container color show
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Account Created!")),
                        );
                      }
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF009688)), // Teal accent
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        ),
        validator: validator ??
                (value) {
              if (value == null || value.isEmpty) {
                return "$label cannot be empty";
              }
              return null;
            },
      ),
    );
  }
}



//----------------Student Home Page-----------------------


