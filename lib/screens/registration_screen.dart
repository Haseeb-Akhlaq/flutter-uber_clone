import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const route = 'registrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();

  var isDeviceConnected = false;
  var subscription;

  String fullName;
  String emailAddress;
  String phoneNumber;
  String password;

  bool isLoading = false;
  bool resetScreen = false;

  Future<void> registerUser(BuildContext ctx) async {
    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    _form.currentState.save();

    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      FirebaseDatabase.instance
          .reference()
          .child('users/${user.user.uid}')
          .set({
        'fullName': fullName,
        'email': emailAddress,
        'phone': phoneNumber,
      });
      _form.currentState?.reset();
      showErrSnackBar('Welcome to UBER $fullName', Colors.black);
    } on FirebaseException catch (err) {
      showErrSnackBar(err.message, Colors.red);
    } catch (err) {
      showErrSnackBar(err.toString(), Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }

  void showErrSnackBar(String message, Color background) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: background,
      duration: Duration(seconds: 2),
    ));
  }

  void checkConnectivity() async {
    isDeviceConnected = await DataConnectionChecker().hasConnection;
    if (isDeviceConnected == false) {
      internetDialog(context);
    }
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity(); // Checks only first time when page starts
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        isDeviceConnected = await DataConnectionChecker().hasConnection;
      }
      if (result == ConnectivityResult.none) {
        isDeviceConnected = false;
      }
      if (isDeviceConnected == false) {
        internetDialog(context);
      }
    });
  }

  internetDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (_) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          title: Text("Connectivity Issues"),
          content: Text("Please check your Internet Connection"),
          actions: <Widget>[
            FlatButton(
              child: Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop();
                if (isDeviceConnected == false) {
                  internetDialog(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
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
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Full Name',
                              hintText: 'Alex',
                              hintStyle: TextStyle(
                                fontSize: 10,
                              )),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide a name.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            fullName = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'EmailAdress',
                              hintText: 'xyz@gmail.com',
                              hintStyle: TextStyle(
                                fontSize: 10,
                              )),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide a value.';
                            }
                            if (!value.contains('@') ||
                                !value.contains('.com')) {
                              return 'Please provide a valid email.';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            emailAddress = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: 'xyz@gmail.com',
                              hintStyle: TextStyle(
                                fontSize: 10,
                              )),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide a value.';
                            }
                            if (value.length < 11) {
                              return 'Phone number is of 11 digits.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            phoneNumber = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Password',
                              hintStyle: TextStyle(
                                fontSize: 10,
                              )),
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide a value.';
                            }
                            if (value.length < 6) {
                              return 'Password must be of 6 characters.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            password = value;
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: RaisedButton(
                            child: isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    'Register',
                                    //style: Styles.raisedButton,
                                  ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            //color: BrandColors.colorGreen,
                            onPressed: () {
                              //checkConnection();
                              registerUser(context);
                            },
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
