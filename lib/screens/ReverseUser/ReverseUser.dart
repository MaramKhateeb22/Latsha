import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mopidati/utiles/constants.dart';

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
            if (snap.hasError) return const Text("Something has error");
            if (snap.data == null) {
              print('empty data');
              const Text("Empty data");
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: snap.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "نوع الحشرة: ${snap.data!.docs[index].data()["Type Insect"]}",
                                // style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "عنوان المكان الذي نتنشر فيه الحشرة \n: ${snap.data!.docs[index].data()["Adress"]}",
                                // style: Theme.of(context).textTheme.titleMedium,
                              ),
                              '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                      '0'
                                  ? const Row(
                                      children: [
                                        Icon(Icons.timelapse_outlined),
                                        Text('الحجز قيد الانتظار')
                                      ],
                                    )
                                  : '${snap.data!.docs[index].data()["statusReverse"]}' ==
                                          '1'
                                      ? const Row(
                                          children: [
                                            Icon(Icons
                                                .check_circle_outline_rounded),
                                            Text('تم قبول الحجز')
                                          ],
                                        )
                                      : const Row(
                                          children: [
                                            Icon(Icons.clear),
                                            Text('تم رفض الحجز'),
                                          ],
                                        ),
                              Row(
                                children: [
                                  MaterialButton(
                                    color: backgroundColor,
                                    elevation: 2,
                                    textColor: pColor,
                                    onPressed: () {},
                                    child: const Text('تعديل الحجز'),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  MaterialButton(
                                    color: backgroundColor,
                                    textColor: pColor,
                                    onPressed: () {
                                      setState(() {});
                                      deleteReverse(
                                          '${snap.data!.docs[index].data()["id"]}');
                                      print(
                                          '${snap.data!.docs[index].data()["id"]}');
                                    },
                                    child: const Text(' حذف الحجز'),
                                  ),
                                ],
                              )
                            ]),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
