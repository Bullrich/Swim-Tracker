import 'package:flutter/material.dart';
import 'package:swimm_tracker/components/report_card.dart';
import 'package:swimm_tracker/components/rounder_modal.dart';
import 'package:swimm_tracker/constants.dart';

class TrackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swim Tracker"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Average",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Expanded(
                        child: ReportCard(
                          title: "Daily",
                          meters: 12,
                          laps: 4,
                        ),
                      ),
                      Expanded(
                        child: ReportCard(
                          title: "Weekly",
                          meters: 1220,
                          laps: 4,
                        ),
                      ),
                      Expanded(
                        child: ReportCard(
                          title: "Total",
                          meters: 15000,
                          laps: 4,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return RoundedModal(colour: kActiveCardColour);
              });
        },
        backgroundColor: kButtonColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
