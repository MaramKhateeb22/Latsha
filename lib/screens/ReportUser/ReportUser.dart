import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mopidati/utiles/constants.dart';

class ReportUser extends StatefulWidget {
  const ReportUser({super.key});

  @override
  State<ReportUser> createState() => _ReportUserState();
}

class _ReportUserState extends State<ReportUser> {
  // Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     return FirebaseFirestore.instance.collection("Report").where().get();
  //     // return null;
  //   }
  //   return null;
  // }

  Future<void> deleteReport(String ReportId) async {
    FirebaseFirestore.instance
        .collection('Reports')
        .doc(ReportId)
        .delete()
        .then((_) => print("Report has been deleted"))
        .catchError((error) => print("Failed to delete Report: $error"));
  }

  Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return FirebaseFirestore.instance
          .collection("Reports")
          .where("idUser", isEqualTo: currentUser.uid)
          .get();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بلاغاتي'),
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
              return const Text("Empty data");
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
                              '${snap.data!.docs[index].data()["statusReport"]}' ==
                                      '0'
                                  ? const Row(
                                      children: [
                                        Icon(Icons.timelapse_outlined),
                                        Text('البلاغ قيد الانتظار')
                                      ],
                                    )
                                  : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                          '1'
                                      ? const Row(
                                          children: [
                                            Icon(Icons
                                                .check_circle_outline_rounded),
                                            Text('تم قبول البلاغ')
                                          ],
                                        )
                                      : const Row(
                                          children: [
                                            Icon(Icons.clear),
                                            Text('تم رفض البلاغ'),
                                          ],
                                        ),
                              Row(
                                children: [
                                  MaterialButton(
                                    color: backgroundColor,
                                    elevation: 2,
                                    textColor: pColor,
                                    onPressed: () {},
                                    child: const Text('تعديل البلاغ'),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  MaterialButton(
                                    color: backgroundColor,
                                    textColor: pColor,
                                    onPressed: () {
                                      setState(() {});
                                      deleteReport(
                                          '${snap.data!.docs[index].data()["id"]}');
                                      print(
                                          '${snap.data!.docs[index].data()["id"]}');
                                    },
                                    child: const Text(' حذف البلاغ'),
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
