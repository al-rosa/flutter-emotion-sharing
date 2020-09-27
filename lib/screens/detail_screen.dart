import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emotion_sharing/components/EmotionChart.dart';
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

  List<Map<String, dynamic>> _statusList;

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

    setState(() {
      _statusList = statuses;
    });
  }

  List<charts.Series<Emotion, int>> _createChartData() {
    if (_statusList == null) return [];

    int count = 0;
    final List<Emotion> data = _statusList.map((status) {
      final int level =
          bigIcons.indexWhere((icon) => icon['emotion'] == status['emotion']);
      return Emotion(count++, level);
    }).toList();

    return [
      new charts.Series<Emotion, int>(
        id: 'emotions',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Emotion emotion, _) => emotion.order,
        measureFn: (Emotion emotion, _) => emotion.level,
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
          child: _statusList != null
              ? EmotionChart(_statusList, _createChartData(), animate: true)
              : Container()),
    );
  }
}

class Emotion {
  final int order;
  final int level;

  Emotion(this.order, this.level);
}
