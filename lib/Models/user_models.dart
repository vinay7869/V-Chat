class UserModels {
  String name;
  String uid;
  String profilePic;
  String phoneNumber;

  UserModels(
      {required this.name,
      required this.phoneNumber,
      required this.profilePic,
      required this.uid});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'phoneNumber': phoneNumber
    };
  }

  factory UserModels.fromMap(Map<String, dynamic> map) {
    return UserModels(
        name: map['name'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        profilePic: map['profilePic'] ?? '',
        uid: map['uid'] ?? '');
  }
}
