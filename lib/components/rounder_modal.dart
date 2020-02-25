import 'package:flutter/material.dart';

class RoundedModal extends StatelessWidget {
  final Color colour;
  final Widget child;

  const RoundedModal({this.colour, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      color: Color(0xFF0A0E21),
      child: Container(
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
