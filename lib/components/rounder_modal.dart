import 'package:flutter/material.dart';

class RoundedModal extends StatelessWidget {
  final Color colour;
  final Widget child;
  final double height;

  const RoundedModal({this.colour, this.child, this.height = 350.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
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
