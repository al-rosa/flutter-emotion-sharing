import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emotion_sharing/constants.dart';

class PostScreen extends StatefulWidget {
  static String id = 'post_screen';

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _memoController = TextEditingController();
  String _selectedEmotion;

  Color getEmotionColor(String emotion) {
    return _selectedEmotion == emotion ? Colors.orange : Colors.black45;
  }

  void _selectIcon(String emotion) {
    setState(() {
      _selectedEmotion = emotion;
    });
  }

  Future<void> _post() async {
    //todo: 別ブランチではmain.dartで初期化処理をしているので、マージしたら消す。
    await Firebase.initializeApp();

    await FirebaseFirestore.instance
        .collection('users')
        .doc('cckf1U7FUgbK7yiHbz9b')
        .collection('statuses')
        .add({
      'emotion': _selectedEmotion,
      'memo': _memoController.text,
      'timestamp': DateTime.now()
    });

    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                content: Text('気持ちを投稿しました。'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'))
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('気持ちの投稿')),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          GridView.count(
              shrinkWrap: true,
              crossAxisCount: 5,
              children: icons
                  .map((icon) => IconButton(
                        icon: icon['icon'],
                        iconSize: 30.0,
                        color: getEmotionColor(icon['emotion']),
                        onPressed: () => _selectIcon(icon['emotion']),
                      ))
                  .toList()),
          TextField(
            controller: _memoController,
            decoration: InputDecoration(hintText: 'メモを入力'),
          ),
          FlatButton(
            child: Text('投稿する'),
            onPressed: () => _post(),
          )
        ],
      )),
    );
  }
}
