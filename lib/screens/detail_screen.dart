import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emotion_sharing/components/EmotionChart.dart';
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
        .limit(7)
        .get();

    List<Map<String, dynamic>> statuses =
        snapshot.docs.map((e) => e.data()).toList();
    Map<String, dynamic> latestStatus = statuses[0];

    final int index = bigIcons
        .indexWhere((icon) => icon['emotion'] == latestStatus['emotion']);
    final icon = bigIcons[index]['icon'];

    setState(() {
      _statusList = statuses;
      _displayIcon = icon;
      _displayMemo = latestStatus['memo'];
      _displayDateTime = (latestStatus['timestamp']).toDate();
    });
  }

  List<charts.Series<EmotionLevel, int>> _createChartData() {
    if (_statusList == null) return [];

    int count = 0;
    final List<EmotionLevel> data = _statusList.map((status) {
      count++;
      final int level =
          bigIcons.indexWhere((icon) => icon['emotion'] == status['emotion']);
      return EmotionLevel(count, level);
    }).toList();

    return [
      new charts.Series<EmotionLevel, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (EmotionLevel level, _) => level.order,
        measureFn: (EmotionLevel level, _) => level.level,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.userName + 'の気持ち')),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 300,
                        padding: EdgeInsets.only(bottom: 20),
                        child: EmotionChart(
                          _createChartData(),
                          animate: true,
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            _displayDateTime != null
                                ? formatDateTime(_displayDateTime)
                                : '',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ),
                _displayIcon ?? Container(),
                Text(
                  _displayMemo != null ? 'コメント：' + _displayMemo : '',
                  style: TextStyle(fontSize: 18),
                )
              ])),
    );
  }
}

class EmotionLevel {
  final int order;
  final int level;

  EmotionLevel(this.order, this.level);
}
