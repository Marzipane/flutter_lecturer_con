class AppText {
  String smtpText({password,name}){
    return 'Hello $name ! We glad to see you in our portal. Your password is $password. Have a nice day !';
  }

  static String smtpSubject = 'Successfully registered';
}