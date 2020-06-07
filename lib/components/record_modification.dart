import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swimm_tracker/components/name_number_picker.dart';
import 'package:swimm_tracker/components/reusable_card.dart';
import 'package:swimm_tracker/models/swim_record.dart';

import '../constants.dart';

class RecordModification extends StatefulWidget {
  final SwimRecord record;
  final Function onSave;
  final Function onDiscard;

  const RecordModification(
      {@required this.record, this.onSave, this.onDiscard});

  @override
  _RecordModificationState createState() => _RecordModificationState(record);
}

class _RecordModificationState extends State<RecordModification> {
  DateTime recordDate;
  int laps;
  int length;

  _RecordModificationState(SwimRecord record) {
    recordDate = DateTime.fromMillisecondsSinceEpoch(record.time);
    laps = record.laps;
    length = record.length;
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMMEEEEd().format(recordDate);
    return ReusableCard(
      colour: kActiveCardColour,
      cardChild: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Edit record",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 5),
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
                  maxValue: 250,
                  onChange: (newVal) {
                    setState(() {
                      length = newVal;
                    });
                  },
                ),
              ],
            ),
            Text(
              "Date",
              style: TextStyle(
                  fontWeight: FontWeight.w700, height: 2, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  formattedDate,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 50,
                  child: MaterialButton(
                    elevation: 6,
                    color: Colors.orangeAccent,
                    child: Icon(Icons.edit),
                    onPressed: () async {
                      final date = await showDatePicker(
                          context: this.context,
                          initialDate: recordDate,
                          firstDate: DateTime(2019, 11, 11),
                          lastDate: DateTime.now(),
                          locale: Locale.fromSubtags(languageCode: 'en'));
                      setState(
                        () {
                          recordDate = date;
                        },
                      );
                    },
                  ),
                )
              ],
            ),
            Divider(
              color: kInactiveCardColour,
              thickness: 5,
              indent: 40,
              endIndent: 40,
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  color: Colors.lightGreen,
                  child: Icon(Icons.check),
                  onPressed: () {
                    final record = SwimRecord(
                        laps: laps,
                        length: length,
                        time: recordDate.millisecondsSinceEpoch,
                        id: widget.record.id);
                    widget.onSave(record);
                  },
                ),
                MaterialButton(
                  color: kCancelColor,
                  child: Icon(Icons.cancel),
                  onPressed: () {
                    widget.onDiscard();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
