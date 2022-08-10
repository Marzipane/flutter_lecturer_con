import 'package:flutter/material.dart';
import 'package:flutter_lecon/pages/lecturer/lecturer_home_page.dart';
import 'package:flutter_lecon/pages/lecturer/ticket_history_page.dart';
import 'package:flutter_lecon/pages/student/student_home_page.dart';
import 'package:flutter_lecon/pages/student/tickets_list_page.dart';
import '../main.dart';
import '../pages/general/profile_page.dart';

class AppBars {


  AppBar builtLecturerAppBar(
      {required user, required context, required title, required auth}) {
    return AppBar(
      leadingWidth: 200,
      automaticallyImplyLeading: false,
      leading: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Image.network(
                'https://www.gau.edu.tr/template/gau/img/gau_logo_en.png'),
          ),
        ],
      ),
      title: PopupMenuButton<String>(
        position: PopupMenuPosition.under,
        // offset: Offset.fromDirection(1, 5),
        child: Container(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title),
              Icon(Icons.keyboard_arrow_down_rounded, size: 40,),
            ],
          ),
        ),
        padding: EdgeInsets.zero,
        onSelected: (String result) {
          switch (result) {
            case 'reply':
              Navigator.popAndPushNamed(context, AuthWrapper.routeName);
              break;
            case 'history':
              Navigator.popAndPushNamed(context, TicketHistoryPage.routeName);
              break;
            default:
          }
        },
        itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'reply',
            child: ListTile(
              title: Text('Reply'),
              trailing: Icon(Icons.question_answer),

            ),
          ),
          const PopupMenuItem<String>(
            value: 'history',
            child: ListTile(
              title: Text('History'),
              trailing: Icon(Icons.history),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () => Navigator.popAndPushNamed(context, '/'),
            icon: Icon(Icons.home_rounded)),
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            icon: CircleAvatar(
              backgroundImage: Image.network(user.photoURL ??
                      'https://upload.wikimedia.org/wikipedia/commons/0/0b/Gau-logo.png')
                  .image,
              radius: 100,
            ),
            onSelected: (String result) {
              switch (result) {
                case 'profile':
                  Navigator.popAndPushNamed(context, ProfilePage.routeName);
                  break;
                case 'logout':
                  auth.signOut(context).then((value) =>
                      Navigator.popAndPushNamed(
                          context, AuthWrapper.routeName));
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'profile',
                child: ListTile(
                  title: Text('Profile'),
                  trailing: Icon(Icons.account_box_outlined),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  title: Text('Log out'),
                  trailing: Icon(Icons.logout_outlined),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  AppBar builtStudentAppBar(
      {required user, required context, required title, required auth}) {
    return AppBar(
      leadingWidth: 200,
      automaticallyImplyLeading: false,
      leading: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Image.network(
                'https://www.gau.edu.tr/template/gau/img/gau_logo_en.png'),
          ),
        ],
      ),
      title: PopupMenuButton<String>(
        position: PopupMenuPosition.under,
        // offset: Offset.fromDirection(1, 5),
        child: Container(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title),
              Icon(Icons.keyboard_arrow_down_rounded, size: 40,),
            ],
          ),
        ),
        padding: EdgeInsets.zero,
        onSelected: (String result) {
          switch (result) {
            case 'ask':
              Navigator.popAndPushNamed(context, AuthWrapper.routeName);
              break;
            case 'history':
              Navigator.popAndPushNamed(context, TicketsListPage.routeName);
              break;
            default:
          }
        },
        itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'ask',
            child: ListTile(
              title: Text('Ask'),
              trailing: Icon(Icons.question_answer_outlined),

            ),
          ),
          const PopupMenuItem<String>(
            value: 'history',
            child: ListTile(
              title: Text('History'),
              trailing: Icon(Icons.history),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () => Navigator.popAndPushNamed(context, '/'),
            icon: Icon(Icons.home_rounded)),
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            icon: CircleAvatar(
              backgroundImage: Image.network(user.photoURL ??
                      'https://upload.wikimedia.org/wikipedia/commons/0/0b/Gau-logo.png')
                  .image,
              radius: 100,
            ),
            onSelected: (String result) {
              switch (result) {
                case 'profile':
                  Navigator.popAndPushNamed(context, ProfilePage.routeName);
                  break;
                case 'logout':
                  auth.signOut(context).then((value) =>
                      Navigator.popAndPushNamed(
                          context, AuthWrapper.routeName));
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'profile',
                child: ListTile(
                  title: Text('Profile'),
                  trailing: Icon(Icons.account_box_outlined),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  title: Text('Log out'),
                  trailing: Icon(Icons.logout_outlined),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
