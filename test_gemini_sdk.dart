import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  final apiKey = "AIzaSyAwN_apxN59lbHUeX7b_TOrkuJzxFlVcF8";
  final model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);

  try {
    final response = await model.generateContent([Content.text("Hello")]);
    print(response.text);
  } catch (e) {
    print("Error: $e");
  }
}
