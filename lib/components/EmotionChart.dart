import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_emotion_sharing/constants.dart';
import 'package:flutter_emotion_sharing/utils.dart';

class EmotionChart extends StatefulWidget {
  final List<Map<String, dynamic>> statusList;
  final List<charts.Series> seriesList;
  final bool animate;

  EmotionChart(this.statusList, this.seriesList, {this.animate, Key key})
      : super(key: key);

  @override
  _EmotionChartState createState() => _EmotionChartState();
}

class _EmotionChartState extends State<EmotionChart> {
  Icon _icon;
  String _memo;
  DateTime _time;

  @override
  void initState() {
    final latestStatus = widget.statusList.last;
    final String memo = latestStatus['memo'];
    final DateTime time = latestStatus['timestamp'].toDate();

    final int index = bigIcons
        .indexWhere((icon) => icon['emotion'] == latestStatus['emotion']);
    final icon = bigIcons[index]['icon'];

    setState(() {
      _icon = icon;
      _memo = memo;
      _time = time;
    });

    super.initState();
  }

  void _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    if (selectedDatum.isEmpty) return;

    final int index = selectedDatum.first.datum.level;
    final Icon icon = bigIcons[index]['icon'];

    final int order = selectedDatum.first.datum.order;
    final Map<String, dynamic> status = widget.statusList[order];
    final String memo = status['memo'];
    final DateTime time = status['timestamp'].toDate();

    setState(() {
      _icon = icon;
      _memo = memo;
      _time = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    // The children consist of a Chart and Text widgets below to hold the info.
    final chartContainerChildren = <Widget>[
      Container(
          height: 300,
          padding: EdgeInsets.only(bottom: 20),
          child: charts.LineChart(
            widget.seriesList,
            animate: widget.animate,
            selectionModels: [
              charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: _onSelectionChanged,
              ),
              // charts.SelectionModelConfig(
              // type: charts.SelectionModelType.action)
            ],
            behaviors: [
              charts.LinePointHighlighter(
                  showHorizontalFollowLine:
                      charts.LinePointHighlighterFollowLineType.none,
                  showVerticalFollowLine:
                      charts.LinePointHighlighterFollowLineType.nearest),
              charts.SelectNearest(
                  eventTrigger: charts.SelectionTrigger.tapAndDrag),
              charts.InitialSelection(selectedDataConfig: [
                charts.SeriesDatumConfig<int>('emotions', 6)
              ]),
            ],
          )),
    ];

    if (_time != null) {
      chartContainerChildren.add(Align(
          alignment: Alignment.centerRight,
          child: Text(
            formatDateTime(_time),
            style: TextStyle(fontSize: 16),
          )));
    }

    final children = <Widget>[
      Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          children: chartContainerChildren,
        ),
      ),
    ];

    if (_icon != null)
      children.add(Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: _icon,
      ));

    if (_memo != null)
      children.add(Text(_memo, style: TextStyle(fontSize: 18)));

    return Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: children));
  }
}
