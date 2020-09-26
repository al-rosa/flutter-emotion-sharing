import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emotion_sharing/constants.dart';
import 'package:flutter_emotion_sharing/utils.dart';

class DetailScreen extends StatefulWidget {
  static String id = 'detail_screen';
  final String userName;

  DetailScreen(this.userName, {Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _statusList;
  Icon _displayIcon;
  String _displayMemo;
  DateTime _displayDateTime;

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
        .get();

    List<Map<String, dynamic>> statuses =
        snapshot.docs.map((e) => e.data()).toList();
    Map<String, dynamic> latestStatus = statuses[0];

    final int index = icons
        .indexWhere((element) => element['emotion'] == latestStatus['emotion']);
    final icon = icons[index]['icon'];

    setState(() {
      _statusList = statuses;
      _displayIcon = icon;
      _displayMemo = latestStatus['memo'];
      _displayDateTime = (latestStatus['timestamp']).toDate();
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
        Align(
            alignment: Alignment.centerRight,
            child: Text(_displayDateTime != null
                ? formatDateTime(_displayDateTime)
                : '')),
        Align(alignment: Alignment.center, child: _displayIcon),
        Text(_displayMemo != null ? _displayMemo : '')
      ])),
    );
  }
}
