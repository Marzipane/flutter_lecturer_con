import 'package:flutter/material.dart';
import 'pages/general/error_page.dart';
import 'pages/general/home_page.dart';
import 'pages/general/login_page.dart';
import 'pages/lecturer/lecturer_home_page.dart';
import 'pages/lecturer/lecturer_profile_page.dart';
import 'pages/lecturer/reply_ticket_page.dart';
import 'pages/student/add_ticket_page.dart';
import 'pages/student/student_home_page.dart';
import 'pages/student/student_profile_page.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => const HomePage());
    } else if (settings.name == LoginPage.routeName) {
      return MaterialPageRoute(builder: (context) => const LoginPage());
    } else if (settings.name == AddTicketPage.routeName) {
      return MaterialPageRoute(
          builder: (context) => const AddTicketPage(), settings: settings);
    } else if (settings.name == StudentProfilePage.routeName) {
      return MaterialPageRoute(
          builder: (context) => const StudentProfilePage());
    } else if (settings.name == LecturerProfilePage.routeName) {
      return MaterialPageRoute(
          builder: (context) => const LecturerProfilePage());
    } else if (settings.name == StudentHomePage.routeName) {
      return MaterialPageRoute(builder: (context) => const StudentHomePage());
    } else if (settings.name == LecturerHomePage.routeName) {
      return MaterialPageRoute(builder: (context) => LecturerHomePage());
    } else if (settings.name == ReplyTicketPage.routeName) {
      return MaterialPageRoute(
          builder: (context) => const ReplyTicketPage(), settings: settings);
    }
    return MaterialPageRoute(builder: (context) => const ErrorPage());
  }
}
