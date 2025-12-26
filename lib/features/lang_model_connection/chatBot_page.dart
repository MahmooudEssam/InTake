import 'package:flutter/material.dart';
import '../../../../features/lang_model_connection/connect.dart';
class StreamChatScreen extends StatefulWidget {
  @override
  _StreamChatScreenState createState() => _StreamChatScreenState();
}

class _StreamChatScreenState extends State<StreamChatScreen> {
  final ScrollController _scrollController = ScrollController();
  String _accumulatedText = ""; // This stores the full response
  bool _isStreaming = false;

  void _sendPrompt() {
    setState(() {
      _accumulatedText = ""; // Clear previous response
      _isStreaming = true;
    });

    // We listen to the stream manually to accumulate the data
    GeminiService().getGeminiResponseStream("Tell me a long story about a robot.")
        .listen(
          (chunk) {
        setState(() {
          _accumulatedText += chunk; // Append new chunk to the existing text
        });
        _scrollToBottom();
      },
      onDone: () => setState(() => _isStreaming = false),
      onError: (error) => setState(() {
        _accumulatedText = "Error: $error";
        _isStreaming = false;
      }),
    );
  }

  // Automatically scroll to the bottom as text grows
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gemini Stream")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                controller: _scrollController, // Attach the scroll controller
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _accumulatedText.isEmpty && !_isStreaming
                          ? "Type something to start."
                          : _accumulatedText,
                      style: const TextStyle(fontSize: 16),
                    ),
                    if (_isStreaming && _accumulatedText.isEmpty)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _isStreaming ? null : _sendPrompt,
              child: Text(_isStreaming ? "Generating..." : "Stream Response"),
            ),
          )
        ],
      ),
    );
  }
}