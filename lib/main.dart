import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emotion_sharing/screens/login_screen.dart';
<<<<<<< HEAD
import 'package:flutter_emotion_sharing/screens/registration_screen.dart';
=======
import 'package:flutter_emotion_sharing/screens/post_screen.dart';
>>>>>>> a451222... Auto stash before rebase of "develop"

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
        initialRoute: RegistrationScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
<<<<<<< HEAD
          RegistrationScreen.id: (context) => RegistrationScreen(),
=======
          PostScreen.id: (BuildContext context) => PostScreen()
>>>>>>> a451222... Auto stash before rebase of "develop"
        });
  }
}
