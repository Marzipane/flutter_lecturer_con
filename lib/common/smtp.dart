import 'dart:html';

import 'package:sendgrid_mailer/sendgrid_mailer.dart';

void sendSmtp({toEmail, text, subject})  async {
  final mailer = Mailer('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');
  var toAddress = Address('${toEmail}');
  final fromAddress = Address('ibrahim.abukeer@std.gau.edu.tr');
  final content = Content('text/plain', '${text}');
  final personalization = Personalization([toAddress]);

  var headers = Map<String, String>();
  headers['Access-Control-Allow-Origin'] = '*';
  headers['Access-Control-Allow-Headers'] = 'Access-Control-Allow-Origin, Accept';
  headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS, PUT, PATCH, DELETE' ;
  headers['Access-Control-Allow-Headers'] = 'X-Requested-With,content-type' ;
  headers['Access-Control-Allow-Credentials'] = 'true' ;



  final email =
  Email([personalization], fromAddress, subject, content: [content], headers: headers);
  mailer.send(email).then((result) {
    print(result);
    print(result.isError);
  });
}