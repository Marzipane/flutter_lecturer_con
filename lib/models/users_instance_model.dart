class UserInstance {
  UserInstance({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.isLecturer,
  });
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final bool isLecturer;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'DisplayName': displayName,
      "PhotoURL": photoURL,
      "isLecturer": isLecturer,
    };
  }

  static UserInstance fromJson(Map<String, dynamic> json){
    return UserInstance(uid: json['uid'], email: json['email'], displayName: json['displayName'], photoURL: json['photoURL'], isLecturer: json['isLecturer']);
  }
}
