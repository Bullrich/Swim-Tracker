import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:swimm_tracker/components/name_number_picker.dart';
import 'package:swimm_tracker/constants.dart';

class RoundedModal extends StatefulWidget {
  final Color colour;

  const RoundedModal({this.colour});

  @override
  _RoundedModalState createState() => _RoundedModalState();
}

class _RoundedModalState extends State<RoundedModal> {
  int currentLaps = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: widget.colour,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NamedNumberPicker(
                      title: "Laps",
                      initialValue: 1,
                      minValue: 1,
                      maxValue: 100,
                    ),
                    NamedNumberPicker(
                      title: "Pool Length",
                      step: 5,
                      initialValue: 5,
                      minValue: 5,
                      maxValue: 150,
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                      child: MaterialButton(
                    onPressed: () {
                      print("PRESSED");
                    },
                    elevation: 6,
                    child: Text("Add record"),
                    color: kButtonColor,
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
