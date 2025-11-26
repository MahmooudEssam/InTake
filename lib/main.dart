import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intake/main.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
    debugPrint("✅ .env loaded successfully!");
  } catch (e) {
    debugPrint("⚠️ Failed to load .env: $e");
  }

  runApp(const InTakeApp());
}

class InTakeApp extends StatelessWidget {
  const InTakeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'inTake',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GroqTestPage(),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('inTake Prototype'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter something for Groq to process...',
              ),
              maxLines: null,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _loading ? null : _sendToGroq,
                icon: const Icon(Icons.send),
                label: _loading
                    ? const Text('Processing...')
                    : const Text('Send to Groq'),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    _output.isEmpty ? 'Output will appear here...' : _output,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
