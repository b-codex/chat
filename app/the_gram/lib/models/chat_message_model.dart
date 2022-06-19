class ChatMessage {
  final String message;
  final String senderID;
  final bool sentByMe;
  ChatMessage({
    required this.message,
    required this.senderID,
    this.sentByMe = false,
  });
  //get sessionID from shared preferences

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['message'] as String,
      senderID: json['senderID'] as String,
    );
  }
}
