import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://172.16.127.239.8080/api/auth';

  // Call this in your login page
  static Future<Map<String, dynamic>?> loginStudent(String studentId, String password) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': studentId, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Assuming backend returns JSON with student details
        return jsonDecode(response.body);
      } else {
        return null; // login failed
      }
    } catch (e) {
      print('Error logging in: $e');
      return null;
    }
  }
}