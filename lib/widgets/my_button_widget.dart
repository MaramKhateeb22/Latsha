import 'package:flutter/material.dart';
import 'package:mopidati/utiles/constants.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({super.key, required this.child, required this.onPressed});
  Widget child;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
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
