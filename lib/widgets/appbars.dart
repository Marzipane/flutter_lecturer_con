import 'package:flutter/material.dart';
import 'package:flutter_lecon/pages/lecturer/ticket_history_page.dart';
import 'package:flutter_lecon/pages/student/tickets_list_page.dart';
import '../main.dart';
import '../pages/general/profile_page.dart';
import '../pages/general/change_password_page.dart';

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
              Navigator.popAndPushNamed(context, '/');
              break;
            case 'history':
              Navigator.popAndPushNamed(context, TicketHistoryPage.routeName);
              break;
            case 'password':
              Navigator.popAndPushNamed(context, ChangeLecturerPasswordPage.routeName);
              break;
            default:
          }
        },
        itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            padding: EdgeInsets.only(left: 5),
            value: 'reply',
            child: ListTile(
              title: Text('Reply'),
              trailing: Icon(Icons.question_answer),

            ),
          ),
          const PopupMenuItem<String>(
            padding: EdgeInsets.only(left: 5),
            value: 'history',
            child: ListTile(
              title: Text('History'),
              trailing: Icon(Icons.history),
            ),
          ),
          const PopupMenuItem<String>(
            padding: EdgeInsets.only(left: 5),
            value: 'password',
            child: ListTile(
              title: Text('Password'),
              trailing: Icon(Icons.password),
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
                  Navigator.popAndPushNamed(context, LecturerProfilePage.routeName);
                  break;
                case 'logout':
                  auth.signOut(context).then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false));
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
              Navigator.popAndPushNamed(context,'/');
              break;
            case 'history':
              Navigator.popAndPushNamed(context, TicketsListPage.routeName);
              break;
            case 'password':
              Navigator.popAndPushNamed(context, ChangeStudentPasswordPage.routeName);
              break;
            default:
          }
        },
        itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            padding: EdgeInsets.only(left: 5),
            value: 'ask',
            child: ListTile(
              title: Text('Ask'),
              trailing: Icon(Icons.question_answer_outlined),

            ),
          ),
          const PopupMenuItem<String>(
            padding: EdgeInsets.only(left: 5),
            value: 'history',
            child: ListTile(
              title: Text('History'),
              trailing: Icon(Icons.history),
            ),
          ),
          const PopupMenuItem<String>(
            padding: EdgeInsets.only(left: 5),
            value: 'password',
            child: ListTile(
              title: Text('Password'),
              trailing: Icon(Icons.password),
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
                  Navigator.popAndPushNamed(context, StudentProfilePage.routeName);
                  break;
                case 'logout':
                  auth.signOut(context).then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false));
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
