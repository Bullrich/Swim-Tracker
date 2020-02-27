import 'package:flutter/material.dart';
import 'package:swimm_tracker/components/record_list.dart';
import 'package:swimm_tracker/components/report_card.dart';
import 'package:swimm_tracker/components/rounder_modal.dart';
import 'package:swimm_tracker/components/track_adder.dart';
import 'package:swimm_tracker/constants.dart';
import 'package:swimm_tracker/models/swim_record.dart';
import 'package:swimm_tracker/services/persistence.dart';

class TrackScreen extends StatefulWidget {
  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  List<SwimRecord> records = [];

  void getAllRecords() async {
    final newRecords = await Persistence().records();
    setState(() {
      records = newRecords.reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getAllRecords();
  }

  List<Widget> generate(int amount) {
    List<Widget> widgets = [];
    for (var i = 0; i < amount; i++) {
      String entryNr = "Entry ${i}";
      widgets.add(
        Container(
          height: 50,
          color: Colors.amber[600],
          child: Center(child: Text(entryNr)),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swim Tracker"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Average",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    ),
                    SizedBox(
                      height: 500,
                      child: RecordList(
                        records: records,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
                context: context,
                builder: (context) {
                  return RoundedModal(
                    colour: kActiveCardColour,
                    child: TrackAdder(),
                  );
                },
            );
            getAllRecords();
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
