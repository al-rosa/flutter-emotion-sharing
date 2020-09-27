import 'package:flutter/material.dart';
import 'package:flutter_emotion_sharing/main.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/rounded_button.dart';
import 'package:flutter_emotion_sharing/constants.dart';

import 'list_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'ログイン',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 38.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'メールアドレス'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'パスワード'),
              ),
              SizedBox(
                height: 30.0,
              ),
              RoundedButton(
                color: Colors.lightBlueAccent,
                title: 'ログイン',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    UserCredential credential =
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);

                    if (credential != null) {
                      currentUser = credential.user;
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.pushNamed(context, ListScreen.id);
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    } else {
                      print(e);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
