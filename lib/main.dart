import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emotion_sharing/screens/detail_screen.dart';
import 'package:flutter_emotion_sharing/screens/login_screen.dart';
import 'package:flutter_emotion_sharing/screens/post_screen.dart';
import 'package:flutter_emotion_sharing/screens/registration_screen.dart';
import 'package:flutter_emotion_sharing/screens/list_screen.dart';
import 'package:flutter_emotion_sharing/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

User currentUser;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'emotion-sharing',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Color.fromARGB(255, 232, 235, 242),
          scaffoldBackgroundColor: Color.fromARGB(255, 250, 252, 255),
        ),
        initialRoute: DetailScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          PostScreen.id: (BuildContext context) => PostScreen(),
          DetailScreen.id: (context) => DetailScreen('テストユーザー'),
          ListScreen.id: (context) => ListScreen(),
        });
  }
}
