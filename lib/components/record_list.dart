import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swimm_tracker/components/alert_popup.dart';
import 'package:swimm_tracker/components/reusable_card.dart';
import 'package:swimm_tracker/constants.dart';
import 'package:swimm_tracker/models/swim_record.dart';
import 'package:swimm_tracker/services/persistence.dart';

class RecordList extends StatelessWidget {
  final List<SwimRecord> records;
  final Function onDeleted;

  RecordList({@required this.records, this.onDeleted});

  List<Widget> parseRecords(BuildContext context) {
    List<Widget> widgets = [
      Text(
        "Past sessions",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      )
    ];

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    for (var i = 0; i < records.length; i++) {
      final record = records[i];
      final date = DateTime.fromMillisecondsSinceEpoch(record.time);
      final dateAbs = DateTime(date.year, date.month, date.day);

      final String dateText = (dateAbs == today)
          ? "Today"
          : (dateAbs == yesterday)
              ? "Yesterday"
              : dateAbs.difference(today).inDays < 7
                  ? DateFormat('EEEE').format(dateAbs)
                  : DateFormat('MMMd').format(dateAbs);

      final container = ReusableCard(
        colour: kActiveCardColour,
        cardChild: Dismissible(
          key: ValueKey(record.time),
          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kCancelColor,
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("${record.laps} laps"),
                Text("${(record.length * record.laps).toString()} meters"),
                Text(dateText),
              ],
            ),
          ),
          onDismissed: (DismissDirection dir) {
            Persistence().deleteTrack(record);
            onDeleted();
          },
          confirmDismiss: (direction) async {
            final bool response = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertPopup(
                  title: "Delete record",
                  content:
                      "Do you wish to delete the record? This can not be undone",
                  yesText: "Delete",
                  noText: "Cancel",
                );
              },
            );

            return response;
          },
        ),
      );

      widgets.add(container);
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    print("I have ${records.length} records!");
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: parseRecords(context),
      ),
    );
  }
}
