import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swimm_tracker/components/alert_popup.dart';
import 'package:swimm_tracker/components/record_modification.dart';
import 'package:swimm_tracker/components/reusable_card.dart';
import 'package:swimm_tracker/components/rounder_modal.dart';
import 'package:swimm_tracker/constants.dart';
import 'package:swimm_tracker/models/swim_record.dart';
import 'package:swimm_tracker/services/persistence.dart';

class RecordList extends StatefulWidget {
  final List<SwimRecord> records;
  final Function onDeleted;

  RecordList({@required this.records, this.onDeleted});

  @override
  _RecordListState createState() => _RecordListState();
}

class _RecordListState extends State<RecordList> {
  SwimRecord currentRecordToModify;

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

    widget.records.sort((a, b) => b.time.compareTo(a.time));

    for (var i = 0; i < widget.records.length; i++) {
      final record = widget.records[i];
      final date = DateTime.fromMillisecondsSinceEpoch(record.time);
      final dateAbs = DateTime(date.year, date.month, date.day);

      final String dateText = (dateAbs == today)
          ? "Today"
          : (dateAbs == yesterday)
              ? "Yesterday"
              : dateAbs.difference(today).inDays > -7
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
              alignment: Alignment.centerLeft,
              child: Icon(Icons.delete),
              padding: EdgeInsets.only(left: 10)),
          secondaryBackground: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.orange,
            ),
            alignment: Alignment.centerRight,
            child: Icon(Icons.edit),
            padding: EdgeInsets.only(right: 10),
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
            widget.onDeleted();
          },
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return RoundedModal(
                    height: 500.0,
                    colour: kActiveCardColour,
                    child: RecordModification(
                      record: record,
                      onSave: (record) async {
                        await Persistence().updateTrack(record);
                        setState(() {
                          widget.onDeleted();
                        });
                        Navigator.pop(context);
                      },
                      onDiscard: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              );
              return false;
            }

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
    return Container(
//      height: 400,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(
          child: child,
          scale: animation,
        ),
        child: currentRecordToModify != null
            ? RecordModification(
                record: currentRecordToModify,
                onSave: (record) async {
                  await Persistence().updateTrack(record);
                  setState(() {
                    currentRecordToModify = null;
                    widget.onDeleted();
                  });
                },
                onDiscard: () {
                  setState(() {
                    currentRecordToModify = null;
                  });
                },
              )
            : Container(
                height: 500,
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: parseRecords(context),
                ),
              ),
      ),
    );
  }
}
