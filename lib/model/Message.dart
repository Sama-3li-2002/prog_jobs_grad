class Message {
  final String content;
  final String? senderMessage;
  String? progImage;
  String? current_time;
  String? current_date;

  Message({required this.content, required this.senderMessage,required this.progImage,required this.current_time,required this.current_date});

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      content: map['messageContent']??"" ,
      senderMessage: map['senderName']??"",
      progImage: map['progImage']??"",
      current_time: map['current_time']??"",
        current_date: map['current_date']??""
    );
  }
}