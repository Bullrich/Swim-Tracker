import 'package:flutter/material.dart';
import 'package:swimm_tracker/components/report_card.dart';
import 'package:swimm_tracker/models/swim_record.dart';

class ReportSection extends StatelessWidget {
  ReportSection({@required this.records})
      : _totalSwam = generateTotalSwamReport(records),
        _dailySwam = generateAverageSwamReport(records);

  static SwimReport generateTotalSwamReport(List<SwimRecord> records) {
    if (records == null || records.length == 0) {
      return null;
    }
    return SwimReport(
        laps: records.map((s) => s.laps).reduce((a, b) => a + b).toDouble(),
        meters: records
            .map((s) => s.length * s.laps)
            .reduce((a, b) => a + b)
            .toDouble());
  }

  static SwimReport generateAverageSwamReport(List<SwimRecord> records) {
    final totalSwam = generateTotalSwamReport(records);

    if (totalSwam == null) {
      return null;
    }

    return SwimReport(
        laps: (totalSwam.laps / records.length),
        meters: (totalSwam.meters / records.length));
  }

  final List<SwimRecord> records;
  final SwimReport _totalSwam;
  final SwimReport _dailySwam;

  @override
  Widget build(BuildContext context) {
    if (records == null || records.length == 0) {
      return Text("No information");
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Expanded(
          child: ReportCard(
            title: "Average",
            meters: _dailySwam.meters,
            laps: _dailySwam.laps,
          ),
        ),
        Expanded(
          child: ReportCard(
            title: "Weekly",
            meters: 1,
            laps: 1,
          ),
        ),
        Expanded(
          child: ReportCard(
            title: "Total",
            laps: _totalSwam.laps,
            meters: (_totalSwam.meters),
          ),
        ),
      ],
    );
  }
}

class SwimReport {
  final double laps;
  final double meters;

  const SwimReport({this.laps, this.meters});
}
