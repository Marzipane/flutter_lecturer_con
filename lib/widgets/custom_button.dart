import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onTap,
      required this.text,
      required this.icon,
      this.iconColor})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  final IconData icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.4),
            borderRadius: BorderRadius.circular(25),
            // radius of 10
            color:
                const Color.fromARGB(41, 158, 158, 158) // green as background color
            ),
        child: ListTile(
          title: Text(
            text,
            textAlign: TextAlign.center,
          ),
          leading: FaIcon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
