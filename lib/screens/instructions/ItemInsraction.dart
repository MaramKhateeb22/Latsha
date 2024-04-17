import 'package:flutter/material.dart';

class ItemInstraction extends StatelessWidget {
  const ItemInstraction({super.key});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    String id = arguments[0];
    String imageLink = arguments[1];
    String adress = arguments[2];
    String details = arguments[3];
    // Tim createdAt = arguments[4];
    return Scaffold(
      appBar: AppBar(
        title: const Text('التفاصيل'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                  imageLink),
              const SizedBox(
                height: 10,
              ),
              Text(adress),
              Text(
                details,
                style: const TextStyle(color: Colors.black, fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
