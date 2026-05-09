import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final apiKey = "AIzaSyAwN_apxN59lbHUeX7b_TOrkuJzxFlVcF8";
  final url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey";

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": "Hello"},
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data["candidates"][0]["content"]["parts"][0]["text"]);
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    print("Error: $e");
  }
}
