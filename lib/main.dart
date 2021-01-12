import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:uber_clone/screens/landing_screen.dart';

import 'file:///C:/Users/haseeb/AndroidStudioProjects/uber_clone/lib/screens/login_screen.dart';
import 'file:///C:/Users/haseeb/AndroidStudioProjects/uber_clone/lib/screens/registration_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  print(FlutterConfig.get('appId'));
  final FirebaseApp app = await Firebase.initializeApp(
    //name: 'com.example.uber_clone',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
            appId: FlutterConfig.get('appId'),
            apiKey: FlutterConfig.get('API_KEY'),
            projectId: FlutterConfig.get('projectId'),
            messagingSenderId: FlutterConfig.get('messagingSenderId'),
            databaseURL: FlutterConfig.get('databaseURL'),
          )
        : FirebaseOptions(
            appId: FlutterConfig.get('appId'),
            apiKey: FlutterConfig.get('API_KEY'),
            projectId: FlutterConfig.get('projectId'),
            messagingSenderId: FlutterConfig.get('messagingSenderId'),
            databaseURL: FlutterConfig.get('databaseURL'),
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
      home: LandingScreen(),
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
