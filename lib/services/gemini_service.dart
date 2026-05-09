import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey = "AIzaSyBBZJwJ7BtJU-QYimvmDZUJhotK4LCXKTg";

  Future<String> sendMessage(String message) async {
    final url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-lite:generateContent?key=$apiKey";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "system_instruction": {
            "parts": [
              {
                "text":
                    "You are WellNex AI, a friendly health & wellness assistant. "
                    "Only answer questions related to health, fitness, mental wellness, nutrition, sleep, and medical topics. "
                    "If the user asks something unrelated to health, politely redirect them back to health topics. "
                    "IMPORTANT: Always provide helpful advice, tips, or solutions first. "
                    "Do NOT keep asking follow-up questions. You may ask at most 1 short clarifying question at the end if truly needed, but always give actionable recommendations upfront. "
                    "Keep every reply concise but informative — around 7 to 10 lines.",
              },
            ],
          },
          "contents": [
            {
              "parts": [
                {"text": message},
              ],
            },
          ],
          "generationConfig": {"maxOutputTokens": 400},
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data["candidates"][0]["content"]["parts"][0]["text"];
      } else {
        return "Error: ${response.body}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
