import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HashtagTimeline extends ConsumerWidget {
  const HashtagTimeline({required this.data, super.key});

  final List<HashtagCheck> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final max = data.map((e) => e.mediaCount!).max()!;

    return Expanded(
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(dateFormat: DateFormat.yMd("fr")),
        primaryYAxis: NumericAxis(/*minimum: max *0.9, maximum: max * 1.1*/),
        tooltipBehavior: TooltipBehavior(
      enable: true,
        ),
        title: ChartTitle(
        text:
        "Historique du hashtag \"${data.first.name?.uppercaseFirst()}\""),
        series: [
      LineSeries(
      dataSource: data,
      xValueMapper: (datum, index) => datum.time,
      yValueMapper: (datum, index) => datum.mediaCount,
      dataLabelSettings: const DataLabelSettings(
        isVisible: true,
      ))
        ],
      ),
    );
  }
}
