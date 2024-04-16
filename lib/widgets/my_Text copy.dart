import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  final dynamic snap; // أضف هنا أي نوع بيانات محدد إذا كان في متناولك
  final int index;
  final String adress;
  TextStyle? style;
  int? maxLines;
  CustomInkWell(
      {Key? key,
      required this.snap,
      required this.adress,
      required this.index,
      this.style,
      this.maxLines = 2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 70,
      child: InkWell(
        child: Text(
          "${snap.data!.docs[index].data()[adress]}",
          style: style,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // هذا الحوار يحتوي على النص الكامل داخل SingleChildScrollView
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Text(
                    "${snap.data!.docs[index].data()[adress]}",
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('اغلاق'),
                    onPressed: () {
                      Navigator.of(context).pop(); // يغلق الحوار
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
