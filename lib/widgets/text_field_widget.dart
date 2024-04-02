import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
   TextFieldWidget({required this.hintText,required this.prefixIcon,required this.onTap});
String hintText;
Widget prefixIcon;
VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return    TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(4.0),
        hintText: hintText,
        prefixIcon:prefixIcon,

        enabledBorder: OutlineInputBorder(),
      ),
      readOnly: true,
      onTap:onTap,
    );
  }
}
