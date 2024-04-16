import 'package:flutter/material.dart';
import 'package:mopidati/utiles/constants.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    super.key,
    required this.child,
    required this.onPressed,
    this.widthFactor,
    this.icon,
    this.backgroundColors = backgroundColor,
    this.colorText,
    this.colorIcon,
    this.side = BorderSide.none,
  });
  var child;
  VoidCallback onPressed;
  double? widthFactor = 1;
  IconData? icon;
  Color? backgroundColors = backgroundColor;
  Color? colorText;
  Color? colorIcon;
  BorderSide side;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          side: side,
          borderRadius: BorderRadius.circular(15.0),
        ),

        color: backgroundColors,
        elevation: 2,
        textColor: pColor,
        // style: ButtonStyle(
        //   // shape: const MaterialStatePropertyAll(),
        //   textStyle: MaterialStateProperty.all(
        //     const TextStyle(
        //         fontSize: 20, fontWeight: FontWeight.bold, color: pColor),
        //   ),
        // backgroundColor: MaterialStateProperty.all<Color>(pColor),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: colorIcon,
            ),
            Text(
              child,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: colorText),
            ),
          ],
        ),
      ),
    );
  }
}
