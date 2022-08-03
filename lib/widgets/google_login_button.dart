import 'package:flutter/material.dart';

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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.black, width: 0.4),
            // radius of 10
            color:
                const Color.fromARGB(41, 158, 158, 158) // green as background color
            ),
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
