import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mopidati/utiles/constants.dart';

class ItemeReport extends StatefulWidget {
  const ItemeReport({super.key});

  @override
  State<ItemeReport> createState() => _ItemeReportState();
}

class _ItemeReportState extends State<ItemeReport> {
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
    int statusReport = arguments[7];
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل البلاغ '),
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
              //             color: getStatusColor(statusReport),
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
                    color: getStatusColor(statusReport),
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
                    color: getStatusColor(statusReport),
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
                    color: getStatusColor(statusReport),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(DateFormat('yyyy-MM-dd').format(createdAt.toDate())),
                  // Text('${createdAt.toDate().minute}'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.timelapse_outlined,
                    color: getStatusColor(statusReport),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(DateFormat('HH:mm:ss').format(createdAt.toDate())),
                  // Text('${createdAt.toDate().minute}'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              statusReport == 0
                  ? Row(
                      children: [
                        Icon(
                          Icons.timer_sharp,
                          color: getStatusColor(statusReport),
                        ),
                        const Text('البلاغ قيد الانتظار'),
                      ],
                    )
                  : statusReport == 1
                      ? Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline_rounded,
                              color: getStatusColor(statusReport),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'تم قبول البلاغ ',
                              style: TextStyle(
                                color: getStatusColor(statusReport),
                              ),
                            ),
                          ],
                        )
                      : Row(children: [
                          Icon(
                            Icons.clear,
                            color: getStatusColor(statusReport),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'تم رفض البلاغ ',
                            style: TextStyle(
                              color: getStatusColor(statusReport),
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
