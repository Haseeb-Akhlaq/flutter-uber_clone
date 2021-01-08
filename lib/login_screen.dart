import 'package:flutter/material.dart';
import 'package:uber_clone/ProjectData/project_style_data.dart';
import 'package:uber_clone/registration_screen.dart';

import './ProjectData/project_style_data.dart';

class LoginScreen extends StatefulWidget {
  static const route = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRegister = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Sign In as a Rider',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'bolt-semibold',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'EmailAdress',
                            hintText: 'xyz@gmail.com',
                            hintStyle: TextStyle(
                              fontSize: 10,
                            )),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Password',
                            hintStyle: TextStyle(
                              fontSize: 10,
                            )),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text('Login', style: Styles.raisedButton),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: BrandColors.colorGreen,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RegistrationScreen.route);
                        },
                        child: Text('Dont have a account signup here'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
