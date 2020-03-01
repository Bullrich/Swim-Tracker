import 'package:flutter/material.dart';
import 'package:swimm_tracker/components/report_card.dart';
import 'package:swimm_tracker/models/swim_record.dart';

class ReportSection extends StatelessWidget {
  ReportSection({@required this.records})
      : _totalSwam = generateTotalSwamReport(records),
        _dailySwam = generateAverageSwamReport(records),
        _weeklyAverageSwam = generateWeekAverageSwamReport(records);

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

  static SwimReport generateWeekAverageSwamReport(List<SwimRecord> records) {
    if (records == null || records.length == 0) {
      return null;
    }

    final now = DateTime.now();

    final weekRecords = records.where((r) =>
        now.difference(DateTime.fromMillisecondsSinceEpoch(r.time)).inDays < 7);

    if (weekRecords == null || weekRecords.length == 0) {
      return SwimReport(laps: 0, meters: 0);
    }
    final weekTotal = SwimReport(
        laps: weekRecords.map((s) => s.laps).reduce((a, b) => a + b).toDouble(),
        meters: weekRecords
            .map((s) => s.length * s.laps)
            .reduce((a, b) => a + b)
            .toDouble());

    return SwimReport(
        laps: weekTotal.laps / weekRecords.length,
        meters: weekTotal.meters / weekRecords.length);
  }

  final List<SwimRecord> records;
  final SwimReport _totalSwam;
  final SwimReport _dailySwam;
  final SwimReport _weeklyAverageSwam;

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
            meters: _weeklyAverageSwam.meters,
            laps: _weeklyAverageSwam.laps,
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
