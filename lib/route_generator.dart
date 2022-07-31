import 'package:flutter/material.dart';
import 'package:flutter_lecon/screens/error_page.dart';
import 'screens/home_page.dart';
import 'screens/student_login.dart';
import 'screens/lecturer_login.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
          builder: (context) => const HomePage());
    } 
    else if(settings.name == StudentLogin.routeName){
      return MaterialPageRoute(
          builder: (context) => const StudentLogin());
    }
        else if(settings.name == LecturerLogin.routeName){
      return MaterialPageRoute(
          builder: (context) => const LecturerLogin());
    }
    return MaterialPageRoute(builder: (context) => const ErrorPage());
  }
}
