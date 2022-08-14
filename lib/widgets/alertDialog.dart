import 'package:flutter/material.dart';

import '../common/app_theme.dart';


class AppAlertDialog extends StatelessWidget {
  final String text;
  final Function submitBtnFunc;
  const AppAlertDialog({Key? key, required this.text, required this.submitBtnFunc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(text),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Submit',
            style: TextStyle(color: AppColors.Green),
          ),
          onPressed: (){
            submitBtnFunc();
          }
        ),
      ],
    );
  }
}
