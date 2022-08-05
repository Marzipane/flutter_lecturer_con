import 'package:flutter/material.dart';

import '../common/app_theme.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({Key? key, required this.onTap, required this.text})
      : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: AppBoxDecoration().all(),
        child: ListTile(
            title: Text(
              text,
              textAlign: TextAlign.center,
            ),
            leading: Image.network(
              'https://freesvg.org/img/1534129544.png',
              width: 30,
            )),
      ),
    );
  }
}
