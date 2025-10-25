import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;




class GroqTestPage extends StatefulWidget {
  const GroqTestPage({super.key});

  @override
  State<GroqTestPage> createState() => _GroqTestPageState();
}

class _GroqTestPageState extends State<GroqTestPage> {
  final TextEditingController _controller = TextEditingController();
  String _output = '';
  bool _loading = false;

  Future<void> _sendToGroq() async {
    final apiKey = dotenv.env['GROQ_API_KEY'];
    final model = dotenv.env['GROQ_MODEL'] ?? 'gpt-4o-mini';
    final input = _controller.text.trim();

    if (apiKey == null || apiKey.isEmpty) {
      setState(() => _output = '❌ Missing GROQ_API_KEY in .env');
      return;
    }

    if (input.isEmpty) {
      setState(() => _output = '⚠️ Please enter some text.');
      return;
    }

    setState(() {
      _loading = true;
      _output = '';
    });

    final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');

    final body = jsonEncode({
      "model": model,
      "messages": [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": input}
      ],
      "max_tokens": 500
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices']?[0]?['message']?['content'] ?? 'No content returned.';
        setState(() => _output = content);
      } else {
        setState(() => _output =
        'Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      setState(() => _output = 'Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }