import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mopidati/screens/reverse/add/newReserve.dart';
import 'package:mopidati/utiles/constants.dart';
import 'package:mopidati/widgets/my_button_widget.dart';

class ReverseUser extends StatefulWidget {
  const ReverseUser({super.key});

  @override
  State<ReverseUser> createState() => _ReverseUserState();
}

class _ReverseUserState extends State<ReverseUser> {
  // Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     return FirebaseFirestore.instance.collection("Report").where().get();
  //     // return null;
  //   }
  //   return null;
  // }
  Future<void> deleteReverse(String ReverseId) async {
    FirebaseFirestore.instance
        .collection('Reverses')
        .doc(ReverseId)
        .delete()
        .then((_) => print("Revers has been deleted"))
        .catchError((error) => print("Failed to delete Report: $error"));
  }

  Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return FirebaseFirestore.instance
          .collection("Reverses")
          .where("idUser", isEqualTo: currentUser.uid)
          .get();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حجوزاتي'),
      ),
      body: FutureBuilder(
        future: initData(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.data?.docs.isEmpty ?? false) {
            print('empty data');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.report,
                    size: 60,
                    color: Colors.yellow,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(" لايوجد لديك حجوزات  "),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewReverseScreen(),
                        ),
                      );

                      // Navigator.pushReplacementNamed(
                      //     context, '/NewReverseScreen');
                      //عند استخدام pushReplacementNamed،
                      //سيتم الانتقال إلى الصفحة '/NewReverseScreen' وإزالة الصفحة الحالية من المكدس بحيث لا تظهر الصفحة الحالية عند
                      // الضغط
                      //على زر
                      // العودة.

                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         const (), // استبدل بالشاشة التي تريد الانتقال إليها
                      //   ),
                      // );
                    },
                    child: const Text('احجز الان'),
                  ),
                ],
              ),
            );
          }
          if (snap.hasError) return const Text("Something has error");
          if (snap.data == null) {
            print('empty data');
            const Text("Empty data");
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            itemCount: snap.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/item-reverse', arguments: [
                      snap.data!.docs[index]['Adress'],
                      snap.data!.docs[index]['Type Insect'],
                      snap.data!.docs[index]['imageLink'],
                      snap.data!.docs[index]['idUser'],
                      snap.data!.docs[index]['id'],
                      snap.data!.docs[index]['createdAt'],
                      snap.data!.docs[index]['location'],
                      snap.data!.docs[index]['space'],
                      snap.data!.docs[index]['statusReverse'],
                    ]);
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    color: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                '0'
                            ? pendingColor
                            : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                    '1'
                                ? acceptColor
                                : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                        '2'
                                    ? rejectColor
                                    : doneColor, // لون الحدود
                        // width: 2.0, // عرض الحدود
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.bug_report,
                                        color: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                '0'
                                            ? pendingColor
                                            : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                    '1'
                                                ? acceptColor
                                                : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                        '2'
                                                    ? rejectColor
                                                    : doneColor),
                                    Text(
                                      "${snap.data!.docs[index].data()["Type Insect"]}",
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                '0'
                                            ? pendingColor
                                            : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                    '1'
                                                ? acceptColor
                                                : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                        '2'
                                                    ? rejectColor
                                                    : doneColor),
                                    SizedBox(
                                      width: 230,
                                      child: Text(
                                        "${snap.data!.docs[index].data()["Adress"]}",
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                        '0'
                                    ? const Row(
                                        children: [
                                          Icon(
                                            Icons.timelapse_outlined,
                                            color: pendingColor,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'الحجز قيد الانتظار',
                                            style: TextStyle(
                                                color: pendingColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                            '1'
                                        ? const Row(
                                            children: [
                                              Icon(
                                                color: acceptColor,
                                                Icons
                                                    .check_circle_outline_rounded,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'تم قبول  الحجز',
                                                style: TextStyle(
                                                    color: acceptColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                '2'
                                            ? const Row(
                                                children: [
                                                  Icon(
                                                    color: rejectColor,
                                                    Icons.clear,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'تم رفض  الحجز',
                                                    style: TextStyle(
                                                        color: rejectColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )
                                            : const Row(
                                                children: [
                                                  Icon(
                                                    Icons.done_all,
                                                    color: doneColor,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'تم الرش',
                                                    style: TextStyle(
                                                        color: doneColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                        '0'
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 27,
                                          ),
                                          ButtonWidget(
                                              side: const BorderSide(
                                                  color: Colors.orange),
                                              colorIcon: Colors.orange,
                                              colorText: Colors.orange,
                                              // backgroundColors: Colors.grey,
                                              icon: Icons.edit,
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/edit-reverse',
                                                  arguments: [
                                                    '${snap.data!.docs[index].data()["id"]}',
                                                    '${snap.data!.docs[index].data()["Type Insect"]}',
                                                    '${snap.data!.docs[index].data()["Adress"]}',
                                                    '${snap.data!.docs[index].data()["space"]}',
                                                    '${snap.data!.docs[index].data()["imageLink"]}'
                                                  ],
                                                );
                                                print(snap.data!.docs[index]
                                                    .data()["id"]);
                                              },
                                              child: 'تعديل'),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          ButtonWidget(
                                              side: const BorderSide(
                                                  color: Colors.red),
                                              colorIcon: Colors.red,
                                              icon: Icons.delete,
                                              colorText: Colors.red,
                                              onPressed: () {
                                                setState(() {
                                                  deleteReverse(
                                                      '${snap.data!.docs[index]}');
                                                });
                                                print(
                                                    '${snap.data!.docs[index]}');
                                              },
                                              child: 'حذف'),
                                        ],
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.all(0),
                                      ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                // clipBehavior: Clip.antiAlias,
                                width: 70,
                                height: 200,
                                color: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                        '0'
                                    ? pendingColor
                                    : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                            '1'
                                        ? acceptColor
                                        : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                '2'
                                            ? rejectColor
                                            : doneColor,
                                child: '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                        '0'
                                    ? const Icon(
                                        Icons.timelapse_rounded,
                                        color: backgroundColor,
                                        size: 25,
                                      )
                                    : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                            '1'
                                        ? const Icon(
                                            Icons.check,
                                            color: backgroundColor,
                                            size: 25,
                                          )
                                        : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                                '2'
                                            ? const Icon(
                                                Icons.clear,
                                                color: backgroundColor,
                                                size: 25,
                                              )
                                            : const Icon(
                                                Icons.done_all,
                                                color: backgroundColor,
                                                size: 25,
                                              ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
          // return ListView.builder(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   itemCount: snap.data?.docs.length ?? 0,
          //   itemBuilder: (context, index) {
          //     return Card(
          //       margin: const EdgeInsets.symmetric(vertical: 4),
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   "نوع الحشرة: ${snap.data!.docs[index].data()["Type Insect"]}",
          //                   // style: Theme.of(context).textTheme.titleMedium,
          //                 ),
          //                 Text(
          //                   "عنوان المكان الذي نتنشر فيه الحشرة \n: ${snap.data!.docs[index].data()["Adress"]}",
          //                   // style: Theme.of(context).textTheme.titleMedium,
          //                 ),
          //                 '${snap.data!.docs[index].data()["statusReverse"]}' ==
          //                         '0'
          //                     ? const Row(
          //                         children: [
          //                           Icon(Icons.timelapse_outlined),
          //                           Text('الحجز قيد الانتظار')
          //                         ],
          //                       )
          //                     : '${snap.data!.docs[index].data()["statusReverse"]}' ==
          //                             '1'
          //                         ? const Row(
          //                             children: [
          //                               Icon(
          //                                   Icons.check_circle_outline_rounded),
          //                               Text('تم قبول الحجز')
          //                             ],
          //                           )
          //                         : const Row(
          //                             children: [
          //                               Icon(Icons.clear),
          //                               Text('تم رفض الحجز'),
          //                             ],
          //                           ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     ButtonWidget(
          //                       side: const BorderSide(
          //                           color: pendingColor,
          //                           style: BorderStyle.solid),
          //                       icon: Icons.edit,
          //                       colorIcon: pendingColor,
          //                       colorText: pendingColor,
          //                       child: "تعديل  ",
          //                       onPressed: () {
          //                         Navigator.pushNamed(
          //                           context,
          //                           '/EditInstarctionScreen',
          //                           arguments: [
          //                             '${snap.data!.docs[index].data()["id"]}',
          //                             '${snap.data!.docs[index].data()["Adress"]}',
          //                             '${snap.data!.docs[index].data()["Details Instraction"]}',
          //                             '${snap.data!.docs[index].data()["imageLink"]}'
          //                           ],
          //                         );
          //                         print(
          //                             '${snap.data!.docs[index].data()["id"]}');
          //                       },
          //                     ),
          //                     const SizedBox(
          //                       width: 15,
          //                     ),
          //                     ButtonWidget(
          //                       side: const BorderSide(
          //                           style: BorderStyle.solid,
          //                           color: rejectColor),
          //                       icon: Icons.delete,
          //                       colorIcon: rejectColor,
          //                       colorText: rejectColor,
          //                       child: "حذف ",
          //                       onPressed: () {
          //                         setState(() {});
          //                         deleteReverse(
          //                             '${snap.data!.docs[index].data()["id"]}');
          //                         print(
          //                             '${snap.data!.docs[index].data()["id"]}');
          //                       },
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
