import 'package:sendgrid_mailer/sendgrid_mailer.dart';

void sendSmtp(toEmail, text, subject)  async {
  final mailer = Mailer('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');
  var toAddress = Address('${toEmail}');
  final fromAddress = Address('ibrahim.abukeer@std.gau.edu.tr');
  final content = Content('text/plain', '${text}');
  final personalization = Personalization([toAddress]);

  final email =
  Email([personalization], fromAddress, subject, content: [content]);
  mailer.send(email).then((result) {
    print(result);
  });
}