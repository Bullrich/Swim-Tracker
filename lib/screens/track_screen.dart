import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swimm_tracker/components/record_list.dart';
import 'package:swimm_tracker/components/report_section.dart';
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
        padding: EdgeInsets.only(left: 25, right: 25, bottom: 90),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Stats",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              ReportSection(
                records: records,
              ),
              Expanded(
                child: RecordList(
                  records: records,
                  onDeleted: () {
                    getAllRecords();
                  },
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
            final prefs = await SharedPreferences.getInstance();
            final laps = prefs.getInt("laps") ?? 1;
            final length = prefs.getInt("length") ?? 10;

            await showModalBottomSheet(
              context: context,
              builder: (context) {
                return RoundedModal(
                  colour: kActiveCardColour,
                  child: TrackAdder(
                    laps: laps,
                    length: length,
                  ),
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
