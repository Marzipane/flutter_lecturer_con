class UserInstance {
  UserInstance({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.isLecturer,
    this.studentNumber,
  });
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final bool isLecturer;
  final String? studentNumber;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      "photoURL": photoURL,
      "isLecturer": isLecturer,
    };
  }

  static UserInstance fromJson(Map<String, dynamic> json){
    return UserInstance(uid: json['uid'], email: json['email'], displayName: json['displayName'], photoURL: json['photoURL'], isLecturer: json['isLecturer'],studentNumber: json['studentNumber']);
  }
}