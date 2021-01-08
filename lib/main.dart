import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/login_screen.dart';
import 'package:uber_clone/registration_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    //name: 'com.example.uber_clone',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
            appId: '1:912363973099:android:2b20a7f2edac39c4b5d1ae',
            apiKey: 'AIzaSyBlf1eCOqsB6dc3TACj4ZVN_noBsR_PExo',
            projectId: 'uberclone-7ed4d',
            messagingSenderId: '912363973099',
            databaseURL: 'https://uberclone-7ed4d-default-rtdb.firebaseio.com',
          )
        : FirebaseOptions(
            appId: '1:912363973099:android:2b20a7f2edac39c4b5d1ae',
            apiKey: 'AIzaSyBlf1eCOqsB6dc3TACj4ZVN_noBsR_PExo',
            messagingSenderId: '912363973099',
            projectId: 'uberclone-7ed4d',
            databaseURL: 'https://uberclone-7ed4d-default-rtdb.firebaseio.com',
          ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'bolt-regular',
      ),
      home: LoginScreen(),
      routes: {
        LoginScreen.route: (ctx) => LoginScreen(),
        RegistrationScreen.route: (ctx) => RegistrationScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HLSDSDLSDLFSDLFDS',
        ),
      ),
      body: Center(
        child: RaisedButton(
          child: Text(
            'Test',
          ),
          onPressed: () {
            FirebaseDatabase.instance
                .reference()
                .child('Test')
                .set('Test Connection');
          },
        ),
      ),
    );
  }
}
