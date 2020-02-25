import 'package:flutter/material.dart';
import 'package:swimm_tracker/components/reusable_card.dart';
import 'package:swimm_tracker/constants.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({this.title, this.laps, this.meters});

  final String title;
  final int laps;
  final int meters;

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
              laps.toString(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Laps",
            ),
            SizedBox(height: 5),
            Text(
              meters.toString(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text("meters"),
          ],
        ),
      ),
    );
  }
}
