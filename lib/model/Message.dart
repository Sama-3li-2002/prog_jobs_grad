class Message {
  final String content;

  Message({required this.content});

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      content: map['messageContent'] ,
    );
  }
}