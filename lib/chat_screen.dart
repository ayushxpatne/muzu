import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _handleSubmitted(String text) {
    _controller.clear();

    _echomessage(text);
    setState(() {
      _messages.add(ChatMessage(text: text, isUserMessage: true));
      // Simulate bot response (replace with actual logic)
    });
  }

  void _echomessage(String message) async {
    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:5000/message'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}), // Example input featurehhewew
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          _messages.add(
            ChatMessage(
                text: data['response'].toString(), isUserMessage: false),
          );
        });
      }
    } catch (e) {
      print('Error making prediction request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Agent Muzu',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28))),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                reverse: false,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ListTile(
                    title: message.isUserMessage
                        ? const Text('ME')
                        : const Text('MUZU'),
                    subtitle: message.isUserMessage
                        ? Text(message.text,
                            style: Theme.of(context).textTheme.titleMedium)
                        : AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                message.text,
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium,
                                speed: const Duration(milliseconds: 30),
                              ),
                            ],
                            totalRepeatCount: 1,
                            pause: const Duration(milliseconds: 30),
                            stopPauseOnTap: true,
                          ),
                    tileColor: message.isUserMessage
                        ? Colors.blue.shade100
                        : Colors.grey.shade200,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0)),
                    isThreeLine: false,
                  );
                },
              ),
            ),
            const Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColorDark),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _controller,
                onSubmitted: _handleSubmitted,
                style: Theme.of(context).textTheme.titleMedium,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_controller.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});
}
