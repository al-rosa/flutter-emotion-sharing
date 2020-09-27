import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_emotion_sharing/main.dart';
import 'package:flutter_emotion_sharing/screens/post_screen.dart';
import 'package:flutter_emotion_sharing/constants.dart';

User loggedInUser = FirebaseAuth.instance.currentUser;
CollectionReference _firestore = FirebaseFirestore.instance.collection('users');

class ListScreen extends StatefulWidget {
  static String id = 'list_screen';

  @override
  _ListScreenState createState() => _ListScreenState();
}

String user = currentUser.email.toString();
String memo = "お腹が痛い";
Widget emotion() {
  return Icon(
    Icons.sentiment_very_dissatisfied,
    size: 60.0,
  );
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 245, 252),
      appBar: AppBar(
        title: Text('emotion'),
        actions: <Widget>[
          //サインアウトボタン
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                //サインアウトの処理
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              }),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'あなたの気持ち',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .doc(currentUser.uid)
                    .collection('statuses')
                    .limit(1)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final String newMemo =
                      snapshot.data.docs.first.data()['memo'];

                  final int index = bigIcons.indexWhere((icon) =>
                      icon['emotion'] ==
                      snapshot.data.docs.first.data()['emotion']);
                  final icon = bigIcons[index]['icon'];

                  return MyEmotion(
                    myUser: user,
                    myMemo: newMemo,
                    myEmotion: icon,
                  );
                },
              ),
              Text(
                'みんなの気持ち',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: ListView(
                  children: [
                    OthersEmotion(
                      othersUser: 'aran@email.com',
                      othersMemo: '彼女に振られた',
                      othersEmotion: Icon(
                        Icons.sentiment_very_dissatisfied,
                        size: 60.0,
                      ),
                    ),
                    OthersEmotion(
                      othersUser: 'tomofumi@eamil.com',
                      othersMemo: memo,
                      othersEmotion: Icon(
                        Icons.sentiment_very_dissatisfied,
                        size: 60.0,
                      ),
                    ),
                    OthersEmotion(
                      othersUser: 'milkBoy@email.com',
                      othersMemo: 'where is my milk coffee',
                      othersEmotion: Icon(
                        Icons.sentiment_very_dissatisfied,
                        size: 60.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PostScreen.id);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class OthersEmotion extends StatelessWidget {
  OthersEmotion({this.othersUser, this.othersMemo, this.othersEmotion});

  final String othersUser;
  final String othersMemo;
  final Widget othersEmotion;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 0.7,
            blurRadius: 7.0,
            offset: Offset(7, 7),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: othersEmotion,
        title: Text(othersUser),
        subtitle: Text(othersMemo),
      ),
    );
  }
}

class MyEmotion extends StatelessWidget {
  MyEmotion({this.myUser, this.myMemo, this.myEmotion});

  final String myUser;
  final String myMemo;
  final Widget myEmotion;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlueAccent,
            spreadRadius: 1.7,
            blurRadius: 10.0,
            offset: Offset(0, 0),
          ),
        ],
        color: Color.fromARGB(255, 5, 128, 240),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: myEmotion,
        title: Text(
          myUser,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          myMemo,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
