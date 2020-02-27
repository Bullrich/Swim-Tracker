import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swimm_tracker/constants.dart';
import 'package:swimm_tracker/models/swim_record.dart';
import 'package:swimm_tracker/services/persistence.dart';

import 'name_number_picker.dart';

class TrackAdder extends StatefulWidget {
  @override
  _TrackAdderState createState() => _TrackAdderState(
        laps: 15,
        length: 10,
      );
}

class _TrackAdderState extends State<TrackAdder> {
  int laps;
  int length;

  _TrackAdderState({this.laps, this.length});

  void getLastValues() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      laps = prefs.getInt("laps") ?? 1;
      length = prefs.getInt("length") ?? 10;
      print("Last values were $laps and $length");
    });
  }

  Future setNewLastValues(int laps, int length) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("laps", laps);
    prefs.setInt("length", length);
  }

  @override
  void initState() {
    super.initState();
    getLastValues();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "Add swimming record",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            NamedNumberPicker(
              title: "Laps",
              initialValue: laps,
              minValue: 1,
              maxValue: 100,
              onChange: (newVal) {
                setState(
                  () {
                    laps = newVal;
                  },
                );
              },
            ),
            NamedNumberPicker(
              title: "Pool Length",
              step: 5,
              initialValue: length,
              minValue: 5,
              maxValue: 150,
              onChange: (newVal) {
                setState(() {
                  length = newVal;
                });
              },
            ),
          ],
        ),
        Expanded(
          child: Center(
              child: MaterialButton(
            onPressed: () async {
              print("PRESSED laps $laps length $length");
              final record = SwimRecord(
                  laps: laps,
                  length: length,
                  time: DateTime.now().millisecondsSinceEpoch);
              await Persistence().insertRecord(record);
              await setNewLastValues(laps, length);
              Navigator.pop(context);
            },
            elevation: 6,
            child: Text("Add record"),
            color: kButtonColor,
          )),
        ),
      ],
    );
  }
}
