class ChatScreenModel {
  String lastMessage;
  String profilePic;
  String name;
  String uid;
  DateTime timeSent;

  ChatScreenModel(
      {required this.profilePic,
      required this.name,
      required this.uid,
      required this.lastMessage,
      required this.timeSent});

  Map<String, dynamic> toMap() {
    return {
      'lastMessage': lastMessage,
      'profilePic': profilePic,
      'name': name,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'uid': uid
    };
  }

  factory ChatScreenModel.fromMap(Map<String, dynamic> map) {
    return ChatScreenModel(
        profilePic: map['profilePic'] ?? '',
        name: map['name'] ?? '',
        lastMessage: map['lastMessage'] ?? '',
        timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
        uid: map['uid'] ?? '');
  }
}
