import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  // Singleton pattern to ensure only one service exists
  static final GeminiService _instance = GeminiService._internal();
  factory GeminiService() => _instance;
  GeminiService._internal();

  GenerativeModel? _model;

  Future<void> init() async {
    // Only initialize if it hasn't been done yet
    if (_model != null) return;

    await dotenv.load(fileName: ".env");
    final apiKey = dotenv.env['GEMINI_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY not found in .env');
    }

    _model = GenerativeModel(
      model: "gemini-3-flash-preview", // Use 'gemini-2.0-flash-exp' for the latest
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.7, // 1.0 is very creative, 0.7 is more balanced
        topK: 40,
        topP: 0.95,
      ),
      // Optional: Add safety settings to prevent blocked responses
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium)
      ],
    );
  }
  // Add this method to your GeminiService class
  Stream<String> getGeminiResponseStream(String prompt) async* {
    if (_model == null) await init();

    try {
      final content = [Content.text(prompt)];
      // Use generateContentStream instead of generateContent
      final responseStream = _model!.generateContentStream(content);

      await for (final chunk in responseStream) {
        final text = chunk.text;
        if (text != null) {
          yield text; // Sends the new piece of text to the UI
        }
      }
    } catch (e) {
      yield "Error: $e";
    }
  }

  Future<String> getGeminiResponse(String prompt) async {
    try {
      if (_model == null) await init();

      final content = [Content.text(prompt)];
      final response = await _model!.generateContent(content);

      return response.text ?? "No response received.";
    } catch (e) {
      return "Error connecting to Gemini: $e";
    }
  }
}