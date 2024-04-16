import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mopidati/utiles/constants.dart';
import 'package:mopidati/widgets/message.dart';
import 'package:mopidati/widgets/my_Text.dart';
import 'package:mopidati/widgets/my_button_widget.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({super.key});

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  Future<QuerySnapshot<Map<String, dynamic>>> initInstraction() async {
    return await FirebaseFirestore.instance.collection("Instractions").get();
  }

  Future<void> deleteInstraction(String instractiontId) async {
    FirebaseFirestore.instance
        .collection('Instractions')
        .doc(instractiontId)
        .delete()
        .then((_) => message(context, 'تم حذف الارشاد بنجاح'))
        .catchError((error) => print("Failed to delete Report: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الارشادات '),
        // leading: const Icon(Icons.menu_book_outlined),
      ),
      body: FutureBuilder(
        future: initInstraction(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) return const Text("Something has error");
          if (snap.data == null) {
            print('empty data');
            return const Text("لم يتم إضافة إرشادات ");
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: snap.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                child: Card(
                  // shadowColor: Colors.grey,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(15.0),
                  // ),
                  // // clipBehavior: Clip.antiAlias,
                  // color: cardbackground,
                  // elevation: 10,
                  // margin: const EdgeInsets.all(4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: pColor,
                                // color: cardbackground,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: 130,
                              height: 130,
                              child: Image.network(
                                  fit: BoxFit.cover,
                                  "${snap.data!.docs[index].data()["imageLink"]}"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomInkWell(
                                  style: const TextStyle(
                                      height: 1.2, fontSize: 23, color: pColor),
                                  // maxLines: 3,
                                  snap: snap,
                                  index: index,
                                  adress: 'Adress',
                                ),
                                CustomInkWell(
                                  snap: snap,
                                  adress: 'Details Instraction',
                                  index: index,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonWidget(
                                side: const BorderSide(
                                    color: pendingColor,
                                    style: BorderStyle.solid),
                                icon: Icons.edit,
                                colorIcon: pendingColor,
                                colorText: pendingColor,
                                child: "تعديل  ",
                                onPressed: () {}),
                            const SizedBox(
                              width: 15,
                            ),
                            ButtonWidget(
                              side: const BorderSide(
                                  style: BorderStyle.solid, color: rejectColor),
                              icon: Icons.delete,
                              colorIcon: rejectColor,
                              colorText: rejectColor,
                              child: "حذف ",
                              onPressed: () {
                                setState(() {});
                                deleteInstraction(
                                    '${snap.data!.docs[index].data()["id"]}');
                                print('${snap.data!.docs[index].data()["id"]}');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
