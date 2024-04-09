import 'package:flutter/material.dart';
import 'package:mopidati/utiles/constants.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget(
      {super.key,
      required this.child,
      required this.onPressed,
      this.widthFactor});
  Widget child;
  VoidCallback onPressed;
  double? widthFactor = 1;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: ElevatedButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(pColor),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
