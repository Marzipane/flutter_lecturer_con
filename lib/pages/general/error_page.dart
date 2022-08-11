import 'package:flutter/material.dart';
import 'package:flutter_lecon/main.dart';

import '../../common/set_page_title.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    setPageTitle('Error 404', context);
    return (Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color(0xffd8f3dc),
      body: Stack(
        children: [
          Positioned(
            top: 24,
            bottom: 200,
            left: 24,
            right: 24,
            child: Container(
              child: Image.asset('images/errorPageBack.png'),
            ),
          ),
          Positioned(
            top: 150,
            bottom: 0,
            left: 24,
            right: 24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '404',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50,
                      letterSpacing: 2,
                      color: const Color(0xff2f3640),
                      fontFamily: 'Anton',
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    const Text(
                      'Sorry, we couldn\'t find the page!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: const Color(0xff2f3640),
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, '/');
                        },
                        child: Text(
                          'Go to Log In page',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
