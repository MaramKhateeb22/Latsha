import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {super.key,
      required this.yourController,
      required this.hintText,
      this.onChanged,
      this.obscureText = false,
      this.validator,
      required this.keyboardType,
      this.suffixIcon});
  TextEditingController yourController;
  String hintText;
  Function(String)? onChanged;
  Function(String)? validator;
  bool obscureText;
  TextInputType keyboardType;
  Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      style: const TextStyle(height: 0.3),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        // hintText: hintText,
        label: Text(hintText),
      ),
      controller: yourController,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        validator;
        return null;
      },
    );
  }
}
