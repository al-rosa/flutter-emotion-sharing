import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class EmotionChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  EmotionChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.LineRendererConfig(includePoints: true));
  }
}
