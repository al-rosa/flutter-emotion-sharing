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

  List<charts.Series<EmotionLevel, int>> _createChartData() {
    if (_statusList == null) return [];

    int count = 0;
    final List<EmotionLevel> data = _statusList.map((status) {
      final int level =
          bigIcons.indexWhere((icon) => icon['emotion'] == status['emotion']);
      return EmotionLevel(count++, level);
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
          child: _statusList != null
              ? EmotionChart(_statusList, _createChartData(), animate: true)
              : Container()),
    );
  }
}

class EmotionLevel {
  final int order;
  final int level;

  EmotionLevel(this.order, this.level);
}
