import 'package:flutter/material.dart';
import 'package:flutter_lecon/screens/add_ticket_page.dart';
import 'package:flutter_lecon/screens/error_page.dart';
import 'package:flutter_lecon/screens/lecturer_home_page.dart';
import 'package:flutter_lecon/screens/reply_ticket_page.dart';
import 'package:flutter_lecon/screens/student_home_page.dart';
import 'package:flutter_lecon/screens/student_profile_page.dart';
import 'screens/home_page.dart';
import 'screens/lecturer_profile_page.dart';
import 'screens/login_page.dart';
import 'screens/error_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => const HomePage());
    } else if (settings.name == LoginPage.routeName) {
      return MaterialPageRoute(builder: (context) => const LoginPage());
    } else if (settings.name == AddTicketPage.routeName) {
      // TODO: Give parameter.
      return MaterialPageRoute(
          builder: (context) => const AddTicketPage(), settings: settings);
    } else if (settings.name == StudentProfilePage.routeName) {
      return MaterialPageRoute(
          builder: (context) => const StudentProfilePage());
    } else if (settings.name == LecturerProfilePage.routeName) {
      return MaterialPageRoute(
          builder: (context) => const LecturerProfilePage());
    } else if (settings.name == StudentHomePage.routeName) {
      return MaterialPageRoute(builder: (context) => StudentHomePage());
    } else if (settings.name == LecturerHomePage.routeName) {
      return MaterialPageRoute(builder: (context) => LecturerHomePage());
    } else if (settings.name == ReplyTicketPage.routeName) {
      return MaterialPageRoute(
          builder: (context) => ReplyTicketPage(), settings: settings);
    }
    return MaterialPageRoute(builder: (context) => const ErrorPage());
  }
}
