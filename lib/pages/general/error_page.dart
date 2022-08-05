import 'package:flutter/material.dart';

import '../../common/set_page_title.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    setPageTitle('Error 404', context);
    return (Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Text(
          'Wrong route',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    ));
  }
}
