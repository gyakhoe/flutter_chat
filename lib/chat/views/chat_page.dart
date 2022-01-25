import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converstaion'),
      ),
      body: const Center(
        child: Text('Conversation Page'),
      ),
    );
  }
}
