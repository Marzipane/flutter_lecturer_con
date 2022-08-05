import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../common/set_page_title.dart';
import '../../widgets/custom_button.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    setPageTitle('Home', context);
    return Scaffold(
      appBar: AppBar(title: const Text('Log in')),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Choose corresponding position',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 33),
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
                          const SizedBox(
                            height: 15,
                          ),
                          CustomButton(
                            onTap: () {
                              Navigator.pushNamed(context, LoginPage.routeName);
                            },
                            text: 'STUDENT',
                            icon: FontAwesomeIcons.graduationCap,
                            iconColor: const Color.fromARGB(255, 133, 173, 233),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            'For Lecturers',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          const SizedBox(
                            height: 15,
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
