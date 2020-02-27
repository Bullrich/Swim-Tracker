import 'package:flutter/material.dart';
import 'package:swimm_tracker/components/reusable_card.dart';
import 'package:swimm_tracker/constants.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({this.title, this.laps, this.meters});

  final String title;
  final double laps;
  final double meters;

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      colour: kActiveCardColour,
      cardChild: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              removeDecimalZeroFormat(laps),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Laps",
            ),
            SizedBox(height: 5),
            Text(
              removeDecimalZeroFormat(meters),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("meters"),
          ],
        ),
      ),
    );
  }
}
