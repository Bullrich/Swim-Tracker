import 'package:flutter/material.dart';
import 'package:swimm_tracker/components/report_card.dart';
import 'package:swimm_tracker/models/swim_record.dart';

class ReportSection extends StatelessWidget {
  ReportSection({@required this.records}) {
    if(records == null || records.length == 0){
      return;
    }

    _totalSwam = SwimReport(
        laps:
            this.records.map((s) => s.laps).reduce((a, b) => a + b).toDouble(),
        meters:
            this.records.map((s) => s.length * s.laps).reduce((a, b) => a + b).toDouble());
    _dailySwam = SwimReport(
        laps: (_totalSwam.laps / this.records.length),
        meters: (_totalSwam.meters / this.records.length));
    print("Daily: laps: ${_totalSwam.laps} / ${this.records.length}=${_dailySwam.laps} | meters: ${(_totalSwam.meters * _totalSwam.laps)} / ${this.records.length}=${_dailySwam.meters}");
  }

  final List<SwimRecord> records;
  SwimReport _totalSwam;
  SwimReport _dailySwam;

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
