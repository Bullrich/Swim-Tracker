import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:swimm_tracker/components/reusable_card.dart';
import 'package:swimm_tracker/constants.dart';

class NamedNumberPicker extends StatelessWidget {
  final String title;
  final int step;
  final int initialValue;
  final int minValue;
  final int maxValue;
  final Function onChange;

  const NamedNumberPicker(
      {this.title,
      this.initialValue,
      this.minValue,
      this.maxValue,
      this.onChange,
      this.step = 1});

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
              Text(title),
              NumberPicker.integer(
                initialValue: initialValue,
                minValue: minValue,
                maxValue: maxValue,
                onChanged: onChange,
                step: step,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
