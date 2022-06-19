class ChatMessage {
  final String message;
  final String senderID;
  // final DateTime sentAt;
  final bool sentByMe;
  ChatMessage({
    required this.message,
    required this.senderID,
    // required this.sentAt,
    this.sentByMe = false,
  });
  //get sessionID from shared preferences

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['message'] as String,
      senderID: json['senderID'] as String,
      // sentAt: DateTime.fromMillisecondsSinceEpoch(json['sentAt'] * 1000),
      // receiverID: json['receiverID'] as String,
      
    );
  }
}
