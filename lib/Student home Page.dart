import 'package:flutter/material.dart';

class StudentHomePage extends StatefulWidget {
  final String studentName;
  final String studentId;
  final String phoneNumber;
  final String stopName;
  final String routeNumber;
  final String collegeName;

  const StudentHomePage({
    super.key,
    required this.studentName,
    required this.studentId,
    required this.phoneNumber,
    required this.stopName,
    required this.routeNumber,
    required this.collegeName,
  });

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  void _showStudentInfoDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.all(24),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Student Details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 22),
              _buildDetailRow("Name", widget.studentName),
              _buildDetailRow("ID", widget.studentId),
              _buildDetailRow("Phone", widget.phoneNumber),
              _buildDetailRow("Stop", widget.stopName),
              _buildDetailRow("Route", widget.routeNumber),
              _buildDetailRow("College", widget.collegeName),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Close", style: TextStyle(color: Colors.blue)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        "$label: $value",
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF1F7),
      appBar: AppBar(
        backgroundColor: Color(0xFF3E64FF),
        elevation: 0,
        title: Text(
          'Welcome, ${widget.studentName}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFE0ECFF),
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF3E64FF)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Color(0xFF1A1A1A)),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.studentName,
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text('Student Info', style: TextStyle(color: Colors.white70, fontSize: 16)),
                            IconButton(
                              icon: Icon(Icons.info_outline, color: Colors.white70, size: 21),
                              onPressed: _showStudentInfoDialog,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.history, "Bus History", () {
              Navigator.pop(context);
            }),
            _buildDrawerItem(Icons.settings, "Settings", () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsPage(
                    phoneNumber: widget.phoneNumber,
                    stopName: widget.stopName,
                  ),
                ),
              );
            }),
            _buildDrawerItem(Icons.contact_phone, "Contact Driver/Admin", () {
              Navigator.pop(context);
              // Add contact logic
            }),
            _buildDrawerItem(Icons.help_outline, "Help", () {
              Navigator.pop(context);
              // Add help logic
            }),
            _buildDrawerItem(Icons.info_outline, "About App ", () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AboutApp()),
              );
            }),
            Spacer(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _buildInfoCard(Icons.bus_alert, 'Next bus: 8:15 AM (Route ${widget.routeNumber})'),
                  SizedBox(height: 12),
                  _buildInfoCard(Icons.notifications_active, 'No alerts currently'),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to map
                    },
                    icon: Icon(Icons.map),
                    label: Text("View Bus Location"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00C9A7),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String text) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF3E64FF)),
        title: Text(
          text,
          style: TextStyle(fontSize: 16, color: Color(0xFF1A1A1A)),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF3E64FF)),
      title: Text(label, style: TextStyle(color: Color(0xFF1A1A1A))),
      onTap: onTap,
    );
  }
}







//------------------------aboutApp Page -----------------------------



class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF1F7), // Light Blue-Gray
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E64FF), // Cool Blue
        title: const Text(" About App", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "BusTrackPro",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E64FF),
              ),
            ),
            const SizedBox(height: 20),

            _buildHeading("Introduction"),
            const SizedBox(height: 8),
            _buildParagraph(
              "BusTrackPro is a smart college bus tracking and communication app designed to enhance the daily travel experience for students. It provides real-time bus location updates, smart routing, and seamless communication between students, drivers, and transport management.",
            ),

            const SizedBox(height: 16),
            _buildHeading("Problem It Solves"),
            const SizedBox(height: 8),
            _buildParagraph(
              "Many students face confusion, long waiting times, and communication gaps when it comes to college transportation. BusTrackPro removes the uncertainty by letting students know:",
            ),
            _buildBullet("Exactly where the bus is"),
            _buildBullet("When it will arrive"),
            _buildBullet("Whom to contact in case of emergencies"),
            const SizedBox(height: 8),
            _buildParagraph(
              "This improves safety, time management, and overall satisfaction with the commute.",
            ),

            const SizedBox(height: 16),
            _buildHeading("Core Purpose"),
            const SizedBox(height: 8),
            _buildBullet("Modernize the transport system with digital tools"),
            _buildBullet("Provide accurate, timely updates"),
            _buildBullet("Make travel safe, predictable, and less stressful"),
            _buildBullet("Reduce dependence on manual notices or guesswork"),

            const SizedBox(height: 16),
            _buildHeading("Key Features"),
            const SizedBox(height: 8),
            _buildBullet("Live bus tracking via GPS"),
            _buildBullet("Real-time updates based on stops"),
            _buildBullet("Arrival time notifications"),
            _buildBullet("Student-specific route details"),
            _buildBullet("Quick contact options for drivers or admins"),
            _buildBullet("User-friendly interface tailored for students"),

            const SizedBox(height: 16),
            _buildHeading("How Does It Help?"),
            const SizedBox(height: 8),
            _buildBullet("Removes guesswork about bus schedules"),
            _buildBullet("Helps students become more punctual"),
            _buildBullet("Enhances travel safety and awareness"),
            _buildBullet("Supports better emergency communication"),
            _buildBullet("Ensures smooth coordination and updates from transport staff"),

            const SizedBox(height: 16),
            _buildHeading("Why Choose BusTrackPro?"),
            const SizedBox(height: 8),
            _buildParagraph(
              "BusTrackPro isn't just another tracking tool. It’s built with student needs in mind—combining modern technology and easy usability. Instead of waiting blindly or relying on outdated info, students now have a reliable, real-time solution at their fingertips.",
            ),
            const SizedBox(height: 8),
            _buildParagraph(
              "It’s the perfect bridge between college transport systems and digital convenience.",
            ),

            const SizedBox(height: 30),
            _buildHeading("App Info"),
            const SizedBox(height: 8),
            _buildBullet("Version: 1.0.0"),
            _buildBullet("Status: Active"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF00C9A7), // Heading color
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        height: 1.5,
        color: Color(0xFF1A1A1A), // Main text color
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16, color: Color(0xFF1A1A1A))),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Color(0xFF1A1A1A)),
            ),
          ),
        ],
      ),
    );
  }
}





//--------------------Settings Page---------------------------

class SettingsPage extends StatefulWidget {
  final String phoneNumber;
  final String stopName;

  const SettingsPage({
    super.key,
    required this.phoneNumber,
    required this.stopName,
  });

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _phoneController;
  late TextEditingController emailController;
  late TextEditingController _stopController;
  late TextEditingController _addressController;
  bool _isLocationEnabled = true;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.phoneNumber);
    emailController = TextEditingController(); // Gmail field
    _stopController = TextEditingController(text: widget.stopName);
    _addressController = TextEditingController();
  }

  void _resetSettings() {
    setState(() {
      _phoneController.text = '';
      emailController.text = '';
      _stopController.text = '';
      _addressController.text = '';
      _isLocationEnabled = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("App settings have been reset.")),
    );
  }

  void _saveSettings() {
    String newPhone = _phoneController.text.trim();
    String newGmail = emailController.text.trim();
    String newStop = _stopController.text.trim();
    String newAddress = _addressController.text.trim();
    bool locationStatus = _isLocationEnabled;

    print("Saved Phone: $newPhone");
    print("Saved Gmail: $newGmail");
    print("Saved Stop: $newStop");
    print("Saved Address: $newAddress");
    print("Location Enabled: $locationStatus");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Settings saved successfully!")),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType type) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: TextField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Color(0xFF707070)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF00C9A7),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF1F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E64FF),
        title: const Text("Settings", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Personal Information"),
            const SizedBox(height: 12),
            _buildTextField('Phone Number', _phoneController, TextInputType.phone),
            const SizedBox(height: 12),
            _buildTextField('Email', emailController, TextInputType.emailAddress), // NEW FIELD
            const SizedBox(height: 12),
            _buildTextField('Stop Name', _stopController, TextInputType.text),
            const SizedBox(height: 12),
            _buildTextField('Address', _addressController, TextInputType.text),
            const SizedBox(height: 24),

            _buildSectionTitle("Preferences"),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text("Location Access"),
              subtitle: Text(_isLocationEnabled ? "Location is ON" : "Location is OFF"),
              value: _isLocationEnabled,
              onChanged: (value) {
                setState(() {
                  _isLocationEnabled = value;
                });
              },
              activeColor: const Color(0xFF00C9A7),
            ),
            const SizedBox(height: 24),

            // Save Button
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save Settings'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E64FF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: _saveSettings,
              ),
            ),
            const SizedBox(height: 12),

            // Reset Button
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Reset App Settings'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: _resetSettings,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
