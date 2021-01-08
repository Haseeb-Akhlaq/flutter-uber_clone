import 'package:flutter/material.dart';
import 'package:uber_clone/ProjectData/project_style_data.dart';
import 'package:uber_clone/login_screen.dart';

import './ProjectData/project_style_data.dart';

class RegistrationScreen extends StatefulWidget {
  static const route = 'registrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                  height: 50,
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
                  'Create a Rider\'s Account',
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
                            labelText: 'Full Name',
                            hintText: 'Alex',
                            hintStyle: TextStyle(
                              fontSize: 10,
                            )),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: 'xyz@gmail.com',
                            hintStyle: TextStyle(
                              fontSize: 10,
                            )),
                        keyboardType: TextInputType.emailAddress,
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
                          child: Text('Register', style: Styles.raisedButton),
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
                              context, LoginScreen.route);
                        },
                        child: Text('Have a RIDER account? signin here'),
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
