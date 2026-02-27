class ChatMessage {
  final String id;
  final String errandId;
  final String senderId;
  final String text;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.errandId,
    required this.senderId,
    required this.text,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      errandId: json['errand_id'],
      senderId: json['sender_id'],
      text: json['text'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'errand_id': errandId,
      'sender_id': senderId,
      'text': text,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
