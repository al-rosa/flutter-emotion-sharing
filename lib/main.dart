import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emotion_sharing/screens/detail_screen.dart';
import 'package:flutter_emotion_sharing/screens/login_screen.dart';
import 'package:flutter_emotion_sharing/screens/post_screen.dart';
import 'package:flutter_emotion_sharing/screens/registration_screen.dart';
import 'package:flutter_emotion_sharing/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'emotion-sharing',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          PostScreen.id: (BuildContext context) => PostScreen(),
          DetailScreen.id: (context) => DetailScreen('テストユーザー')
        });
  }
}
