import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void sendSmtp()  async {
  String username = 'loolikwoow@gmail.com';
  String password = 'mi2LkcKYZkLJ';

  final smtpServer = SmtpServer('smtp-pulse.com',port: 465,password: password, ssl: true,allowInsecure: true, username:username,);

  final message = Message()
    ..from = Address('roman.chernogorov@std.gau.edu.tr', 'ROMAN')
    ..recipients.add('destination@example.com')
    ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}