import '../common/formatter.dart';

class Ticket{
  Ticket({
    required this.title,
    required this.description,
    required this.id,
    required this.studentUid,
    required this.teacherUid,
    this.status = "NR",
    this.reply,
  });
  final String? id;
  final String? title;
  final String? description;
  final String? studentUid;
  final String? teacherUid;
  final String? status;
  final String? reply;



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      "creator": studentUid,
      "receiver": teacherUid,
      "status": Formatters().formatStatus(status!),
      "reply": reply ?? ""
    };
  }

  static Ticket fromJson(Map<String, dynamic> json) {
    return Ticket(
        title: json['title'],
        studentUid: json['creator'],
        teacherUid: json['receiver'],
        status: json['status'],
        id: json['id'],
        reply: json['reply'],
        description: json['description']);
  }
}