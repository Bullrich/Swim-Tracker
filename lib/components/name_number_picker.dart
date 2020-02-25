import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:swimm_tracker/components/reusable_card.dart';
import 'package:swimm_tracker/constants.dart';

class NamedNumberPicker extends StatefulWidget {
  final String title;
  final int step;
  final int initialValue;
  final int minValue;
  final int maxValue;

  const NamedNumberPicker(
      {this.title,
      this.initialValue,
      this.minValue,
      this.maxValue,
      this.step = 1});

  @override
  _NamedNumberPickerState createState() =>
      _NamedNumberPickerState(currentValue: step);
}

class _NamedNumberPickerState extends State<NamedNumberPicker> {
  int currentValue = 1;

  _NamedNumberPickerState({this.currentValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ReusableCard(
        colour: kInactiveCardColour,
        cardChild: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(widget.title),
              NumberPicker.integer(
                initialValue: currentValue,
                minValue: widget.minValue,
                maxValue: widget.maxValue,
                onChanged: (val) {
                  setState(() {
                    currentValue = val;
                  });
                },
                step: widget.step,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
