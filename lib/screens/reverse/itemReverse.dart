import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mopidati/utiles/constants.dart';

class ItemeReverse extends StatefulWidget {
  const ItemeReverse({super.key});

  @override
  State<ItemeReverse> createState() => _ItemeReverseState();
}

class _ItemeReverseState extends State<ItemeReverse> {
  // Future<String> getAddress(double latitude, double longitude) async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(latitude, longitude);
  //   Placemark place = placemarks[0];
  //   return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
  // }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    String adress = arguments[0];
    String typeInsect = arguments[1];
    String imageLink = arguments[2];
    String iduser = arguments[3];
    String id = arguments[4];
    Timestamp createdAt = arguments[5];
    String location = arguments[6];
    String space = arguments[7];
    int statusReverse = arguments[8];
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل  الحجز '),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // width: double.infinity,
                // height: 200,
                child: Image.network(
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                    imageLink),
              ),
              const SizedBox(
                height: 10,
              ),
              // FutureBuilder<List<String>>(
              //   future: displayUserNames(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const CircularProgressIndicator();
              //     } else if (snapshot.hasError) {
              //       return Text('Error: ${snapshot.error}');
              //     } else if (snapshot.hasData) {
              //       return Row(
              //         children: [
              //           Icon(
              //             Icons.person,
              //             color: getStatusReverseColor(statusReverse),
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Text(snapshot.data!.first),
              //         ],
              //       );
              //     } else {
              //       return const Text('لا يوجد بيانات للعرض');
              //     }
              //   },
              // ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.bug_report,
                    color: getStatusReverseColor(statusReverse),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(typeInsect),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: getStatusReverseColor(statusReverse),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(adress),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.date_range,
                    color: getStatusReverseColor(statusReverse),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd').format(
                      createdAt.toDate(),
                    ),
                  ),
                  // Text('${createdAt.toDate().minute}'),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.timelapse_outlined,
                    color: getStatusReverseColor(statusReverse),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat('HH:mm:ss').format(
                      createdAt.toDate(),
                    ),
                  ),
                  // Text('${createdAt.toDate().minute}'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.space_dashboard_outlined,
                    color: getStatusReverseColor(statusReverse),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('$space كم'),
                  // Text('${createdAt.toDate().minute}'),
                ],
              ),
              statusReverse == 0
                  ? Row(
                      children: [
                        Icon(
                          Icons.timer_sharp,
                          color: getStatusReverseColor(statusReverse),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'الحجز قيد الانتظار',
                          style: TextStyle(
                            color: getStatusReverseColor(statusReverse),
                          ),
                        ),
                      ],
                    )
                  : statusReverse == 1
                      ? Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline_rounded,
                              color: getStatusReverseColor(statusReverse),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'تم قبول الحجز ',
                              style: TextStyle(
                                color: getStatusReverseColor(statusReverse),
                              ),
                            ),
                          ],
                        )
                      : statusReverse == 2
                          ? Row(children: [
                              Icon(
                                Icons.clear,
                                color: getStatusReverseColor(statusReverse),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'تم رفض الحجز ',
                                style: TextStyle(
                                  color: getStatusReverseColor(statusReverse),
                                ),
                              ),
                            ])
                          : Row(children: [
                              Icon(
                                Icons.done_all,
                                color: getStatusReverseColor(statusReverse),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'تم  الرش ',
                                style: TextStyle(
                                  color: getStatusReverseColor(statusReverse),
                                ),
                              ),
                            ]),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
