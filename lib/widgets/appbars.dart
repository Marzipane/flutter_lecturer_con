import 'package:flutter/material.dart';

import '../pages/lecturer/lecturer_profile_page.dart';

class AppBars {
  double toolbarHeight = 44.0;

  AppBar user(user,context) {
    var choices = ['Profile', 'Log out'];
    return AppBar(
      leadingWidth: 74,
      automaticallyImplyLeading: false,
      toolbarHeight: toolbarHeight,
      leading: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Image.network(
            'https://www.gau.edu.tr/template/gau/img/gau_logo_en.png'),
      ),
      title: Text('Home page'),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: PopupMenuButton<String>(
            icon: CircleAvatar(
              backgroundImage: Image.network(user.photoURL ??
                      'https://upload.wikimedia.org/wikipedia/commons/0/0b/Gau-logo.png')
                  .image,
              radius: 100,
            ),
            onSelected: (String result) {
              switch (result) {
                case 'profile':
                  Navigator.pushNamed(context, LecturerProfilePage.routeName);
                  break;
                case 'logout':
                  print('filter 2 clicked');
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
      elevation: 0.0,
    );
  }
}
