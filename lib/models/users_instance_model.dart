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
    return UserInstance(uid: json['uid'], email: json['email'], displayName: json['DisplayName'], photoURL: json['PhotoURL'], isLecturer: json['isLecturer']);
  }
}
// todo : ДАНЯ ТЫ ДЯТЕЛ ЕБУЧИЙ. ЕСЛИ ТЫ В БАЗУ ДАННЫХ ОТПРАВЛЯЕШЬ С БОЛЬШОЙ БУКВЫ НАЗВАНИЕ, ПРИНИМАЙ СУКА ТОЖЕ С БОЛЬШОЙ БУКВЫ БЛЯТЬ !