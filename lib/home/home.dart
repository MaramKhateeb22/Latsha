import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mopidati/widgets/text_field_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              const Image(image: AssetImage('assets/images/photo_logo.jpg')),
              const Text('مركز مبيداتي'),
              const Text('يسعد بخدمتكم '),
              TextFieldWidget(
                  hintText: 'بلاغ جديد',
                  prefixIcon: const Icon(
                    Icons.add,
                    // size:  ScreenUtil().setSp(20),
                  ),
                  onTap: () {}),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                hintText: 'بلاغاتي',
                prefixIcon: const Icon(
                  FontAwesomeIcons.fileSignature,
                ),
                onTap: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                hintText: 'أضف فكرة ',
                prefixIcon: const Icon(
                  FontAwesomeIcons.lightbulb,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
