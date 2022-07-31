import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/custom_button.dart';
import 'lecturer_login.dart';
import 'student_login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log in')),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Choose corresponding position',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 33),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            'For Students',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomButton(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, StudentLogin.routeName);
                            },
                            text: 'STUDENT',
                            icon: FontAwesomeIcons.graduationCap,
                            iconColor: Color.fromARGB(255, 133, 173, 233),
                          ),
                        ],
                      ),
                    ),
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            'For Lecturers',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomButton(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, LecturerLogin.routeName);
                            },
                            text: 'LECTURER',
                            icon: FontAwesomeIcons.certificate,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
