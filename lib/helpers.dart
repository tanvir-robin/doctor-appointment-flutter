import 'dart:convert'; // For JSON encoding
import 'package:http/http.dart' as http;

class EmailService {
  // Define the URL and Bearer token
  final String _url = "https://api.mailersend.com/v1/email";
  final String _apiKey =
      "mlsn.91f086b3eb5bdd4c9b7830f82a865a9062b7631b39fbcb78f5cca10e5fa7c482";

  // Function to send the OTP email
  Future<void> sendOtpEmail(String recipientEmail, String otp) async {
    // Create the POST request body
    final Map<String, dynamic> body = {
      "from": {"email": "contact@trial-pq3enl6m72rg2vwr.mlsender.net"},
      "to": [
        {"email": recipientEmail}
      ],
      "personalization": [
        {
          "email": recipientEmail,
          "data": {"otp": otp, "support_email": "support@algorixit.com"}
        }
      ],
      "subject": "Your OTP Code",
      "template_id": "pr9084z3qkmlw63d"
    };

    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode(body),
      );

      // Check the status code of the response
      if (response.statusCode == 200 || response.statusCode == 202) {
        // Success
        print("Email sent successfully!");
      } else {
        // Error handling
        print("Failed to send email: ${response.body}");
      }
    } catch (e) {
      // Catch any errors
      print("Error sending email: $e");
    }
  }
}
