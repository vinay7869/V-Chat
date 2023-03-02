import 'package:whp/Common/enums.dart';

class MessageScreenModel {
  String text;
  String senderId;
  String receiverName;
  String messageId;
  String receiverId;
  DateTime timeSent;
  MessageEnums type;

  MessageScreenModel(
      {required this.senderId,
      required this.receiverId,
      required this.receiverName,
      required this.messageId,
      required this.text,
      required this.timeSent,
      required this.type});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'messageId': messageId,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'senderId': senderId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'type': type.type
    };
  }

  factory MessageScreenModel.fromMap(Map<String, dynamic> map) {
    return MessageScreenModel(
      senderId: map['senderId'] ?? '',
      text: map['text'] ?? '',
      receiverId: map['receiverId'] ?? '',
      receiverName: map['receiverName'],
      messageId: map['messageId'] ?? '',
      type: (map['type'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
    );
  }
}
