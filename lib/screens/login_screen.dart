import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/ProjectData/project_style_data.dart';
import 'package:uber_clone/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static const route = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();

  var isDeviceConnected = false;
  var subscription;

  String emailAddress;
  String password;

  bool isLoading = false;

  Future<void> signIn(BuildContext ctx) async {
    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    _form.currentState.save();

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      _form.currentState?.reset();
    } on FirebaseException catch (err) {
      showErrSnackBar(err.message, Colors.red);
    } catch (err) {
      showErrSnackBar(err.toString(), Colors.red);
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showErrSnackBar(String message, Color background) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: background,
      duration: Duration(seconds: 2),
    ));
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _connectivity.disposeStream();
  // }

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
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: 'haseebakhlaq2000@gmail.com',
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
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: '123456',
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
                          child: isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : RaisedButton(
                                  child: Text(
                                    'Login',
                                    style: Styles.raisedButton,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  color: BrandColors.colorGreen,
                                  onPressed: () {
                                    signIn(context);
                                  },
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
