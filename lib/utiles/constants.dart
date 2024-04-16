import 'package:flutter/material.dart';

const Color pColor = Colors.green;
const Color sColor = Colors.blue;
const Color backgroundColor = Colors.white;
const Color cardbackground = Color.fromARGB(255, 240, 237, 237);
const Color rejectColor = Colors.red;
const Color pendingColor = Colors.orange;
const Color acceptColor = Colors.green;
const Color doneColor = Colors.pink;
Color getStatusColor(int statusReport) {
  if (statusReport == 0) {
    return Colors.orange;
  } else if (statusReport == 1) {
    return Colors.green;
  } else {
    return Colors.red;
  }
}

Color getStatusReverseColor(int statusReverse) {
  if (statusReverse == 0) {
    return Colors.orange;
  } else if (statusReverse == 1) {
    return Colors.green;
  } else {
    if (statusReverse == 2) {
      return Colors.red;
    }
    return Colors.pink;
  }
}
