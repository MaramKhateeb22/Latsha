import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void message(BuildContext context, String msg, {int longTime = 5}) {
  ToastContext toastContext = ToastContext();
  toastContext.init(context);
  Toast.show(msg, duration: longTime);
}
