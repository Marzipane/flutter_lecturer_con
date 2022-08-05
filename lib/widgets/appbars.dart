

import 'package:flutter/material.dart';
import 'package:flutter_lecon/services/firebase_auth_methods.dart';
import '../pages/general/login_page.dart';
import '../pages/general/profile_page.dart';

class AppBars {
  AppBar user({required user, required context, required title ,required auth}) {
    var choices = ['Profile', 'Log out'];
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
      title: Text(title),
      actions: [
        IconButton(onPressed: () => Navigator.popAndPushNamed(context, '/'), icon: Icon(Icons.home_rounded)),
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
                  Navigator.pushNamed(context, ProfilePage.routeName);
                  break;
                case 'logout':
                    auth.signOut(context).then(
                            (value) => Navigator.popAndPushNamed(
                            context, LoginPage.routeName));
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
