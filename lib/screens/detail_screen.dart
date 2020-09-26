import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emotion_sharing/constants.dart';

class DetailScreen extends StatefulWidget {
  static String id = 'detail_screen';
  final String userName;

  DetailScreen(this.userName, {Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _statusId;
  Icon _icon;
  String _memo;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  Future<void> _initialize() async {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc('cckf1U7FUgbK7yiHbz9b')
        .collection('statuses')
        .limit(1)
        .get();
    
    Map<String,dynamic> status = snapshot.docs.first.data(); 
    
    final int index =icons.indexWhere((element) => element['emotion']==status['emotion']) ;
    final icon = icons[index]['icon'];
    
   setState(() {
     _icon = statu['emotion']
   }); 
  }

  // Future<void> _setStatus() {
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.userName + 'の気持ち')),
      body: Container(
          child: Column(children: <Widget>[
        Container(),
        Align(alignment: Alignment.center, child: _icon),
        Text(_memo != null ? _memo : '')
      ])),
    );
  }
}
