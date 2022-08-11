import 'package:flutter/material.dart';
import 'package:flutter_lecon/main.dart';
import 'package:flutter_lecon/pages/lecturer/ticket_history_page.dart';
import 'package:flutter_lecon/pages/student/tickets_list_page.dart';
import 'common/create_route.dart';
import 'pages/general/error_page.dart';
import 'pages/general/home_page.dart';
import 'pages/general/login_page.dart';
import 'pages/lecturer/lecturer_home_page.dart';
import 'pages/general/profile_page.dart';
import 'pages/lecturer/reply_ticket_page.dart';
import 'pages/student/add_ticket_page.dart';
import 'pages/general/change_password_page.dart';
import 'pages/student/student_home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        {
          return createRoute(page: const HomePage());
        }
      case LoginPage.routeName:
        {
          return createRoute(page: const LoginPage());
        }
      case AddTicketPage.routeName:
        {
          return createRoute(page: const AddTicketPage(), settings: settings);
        }
      case ProfilePage.routeName:
        {
          return createRoute(page: const ProfilePage());
        }
      case StudentHomePage.routeName:
        {
          return createRoute(page:  StudentHomePage());
        }
      case LecturerHomePage.routeName:
        {
          return createRoute(page: LecturerHomePage());
        }
      case ReplyTicketPage.routeName:
        {
          return createRoute(page: const ReplyTicketPage(), settings: settings);
        }
      case TicketsListPage.routeName:
        {
          return createRoute(page: TicketsListPage());
        }
      case TicketHistoryPage.routeName:
        {
          return createRoute(page: TicketHistoryPage());
        }
      case AuthWrapper.routeName:{
        return createRoute(page: AuthWrapper());
      }
      case ChangeStudentPasswordPage.routeName:{
        return createRoute(page: ChangeStudentPasswordPage());
      }
      case ChangeLecturerPasswordPage.routeName:{
        return createRoute(page: ChangeLecturerPasswordPage());
      }
      default:
        {
          return createRoute(page: const ErrorPage());
        }
    }
  }
}
