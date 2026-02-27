import 'package:flutter/material.dart';
import 'package:models/models.dart';

class ChatOverlay extends StatefulWidget {
  final String errandId;
  const ChatOverlay({super.key, required this.errandId});

  @override
  State<ChatOverlay> createState() => _ChatOverlayState();
}

class _ChatOverlayState extends State<ChatOverlay> {
  final List<ChatMessage> _messages = [];
  final _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.insert(0, ChatMessage(
        id: DateUtils.dateOnly(DateTime.now()).toString(),
        errandId: widget.errandId,
        senderId: 'customer',
        text: _controller.text,
        createdAt: DateTime.now(),
      ));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const Text('Chat with Runner', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isMe = msg.senderId == 'customer';
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.teal : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg.text, style: TextStyle(color: isMe ? Colors.white : Colors.black)),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(hintText: 'Type a message...'),
                ),
              ),
              IconButton(icon: const Icon(Icons.send, color: Colors.teal), onPressed: _sendMessage),
            ],
          ),
        ],
      ),
    );
  }
}
