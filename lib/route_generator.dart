import 'package:flutter/material.dart';
import 'package:flutter_lecon/screens/error_page.dart';
import 'screens/home_page.dart';
import 'screens/student_login_page.dart';
import 'screens/lecturer_login_page.dart';
import 'screens/error_page.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
          builder: (context) => const HomePage());
    } 
    else if(settings.name == StudentLoginPage.routeName){
      return MaterialPageRoute(
          builder: (context) => const StudentLoginPage());
    }
        else if(settings.name == LecturerLoginPage.routeName){
      return MaterialPageRoute(
          builder: (context) => const LecturerLoginPage());
    }
    return MaterialPageRoute(builder: (context) => const ErrorPage());
  }
}
