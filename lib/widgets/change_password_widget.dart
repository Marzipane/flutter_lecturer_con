import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../common/app_theme.dart';
import '../main.dart';
import '../services/firebase_auth_methods.dart';
import '../utils/show_snackbar.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({Key? key}) : super(key: key);

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final TextEditingController _changePasswordController =
  TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _hidePass = true;

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 600,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Enter new password',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 15),
              Form(
                key: formKey,
                child: TextFormField(
                  controller: _changePasswordController,
                  obscureText: _hidePass,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Password ...',
                    icon: const Icon(Icons.security),
                    suffixIcon: IconButton(
                      icon: Icon(_hidePass
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _hidePass = !_hidePass;
                        });
                      },
                    ),
                    // when the field is not in focus
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey)),
                    // when the field is in focus
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.black)),
                    errorStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.ErrorRed,
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(40),
                  ],
                  validator: (String? value) => _validatePassword(value),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      String password = _changePasswordController.text;
                      addNewPassword(docId: user.uid, password: password)
                          .then((value) {
                        return Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                      });
                      showSnackBar(
                          context, 'Password is changed successfully');
                    }
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ],
    );
  }
  _validatePassword(String? value) {
    final RegExp passRegExp = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])");
    if (value!.isEmpty) {
      return 'Password is required';
    } else if (!passRegExp.hasMatch(value)) {
      return 'At least one capital letter, small letters, numbers.';
    }
    return null;
  }
}

Future addNewPassword({required docId, required password}) async {
  final docTicket = FirebaseFirestore.instance.collection('users').doc(docId);
  docTicket.update({'password': password});
}