import 'package:flutter/material.dart';
import 'package:swimm_tracker/components/report_card.dart';
import 'package:swimm_tracker/components/rounder_modal.dart';
import 'package:swimm_tracker/components/track_adder.dart';
import 'package:swimm_tracker/constants.dart';
import 'package:swimm_tracker/services/persistence.dart';

class TrackScreen extends StatelessWidget {
  void printAllRecords() async {
    var records = await Persistence().records();
    print("There are ${records.length} records!");
    records.forEach((r) => {
          print("Record: laps: ${r.laps} - " +
              "length: ${r.length} - " +
              "time: ${DateTime.fromMillisecondsSinceEpoch(r.time)}")
        });
  }

  @override
  Widget build(BuildContext context) {
    printAllRecords();
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return RoundedModal(
                    colour: kActiveCardColour,
                    child: TrackAdder(
                      initialLaps: 3,
                      initialLength: 10,
                    ),
                  );
                });
          },
          backgroundColor: kButtonColor,
          child: Icon(
            Icons.add,
            color: kInactiveCardColour,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
