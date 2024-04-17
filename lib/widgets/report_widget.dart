// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mopidati/utiles/constants.dart';
// import 'package:mopidati/widgets/my_button_widget.dart';

// class ReportListView extends StatefulWidget {
//   final AsyncSnapshot snap;
//   // final FutureBuilder Function(int index)
//   // futureBuilder; // توقيع الدالة التي تقبل int وترجع FutureBuilder.
//   const ReportListView({
//     super.key,
//     required this.snap,
//     // required this.futureBuilder,
//   });

//   @override
//   State<ReportListView> createState() => _ReportListViewState();
// }

// class _ReportListViewState extends State<ReportListView> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: 7),
//       itemCount: widget.snap.data?.docs.length ?? 0,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
//           child: Card(
//             clipBehavior: Clip.antiAlias,
//             color: backgroundColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//               side: BorderSide(
//                 color: '${widget.snap.data!.docs[index].data()["statusReport"]}' ==
//                         '0'
//                     ? pendingColor
//                     : '${widget.snap.data!.docs[index].data()["statusReport"]}' ==
//                             '1'
//                         ? acceptColor
//                         : rejectColor, // لون الحدود
//                 // width: 2.0, // عرض الحدود
//               ),
//             ),
//             margin: const EdgeInsets.symmetric(vertical: 4),
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(0.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Padding(
//                         //   padding: const EdgeInsets.symmetric(vertical: 0),
//                         //   child: futureBuilder(index),
//                         // ),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.bug_report,
//                               color: '${widget.snap.data!.docs[index].data()["statusReport"]}' ==
//                                       '0'
//                                   ? pendingColor
//                                   : '${widget.snap.data!.docs[index].data()["statusReport"]}' ==
//                                           '1'
//                                       ? acceptColor
//                                       : rejectColor,
//                             ),
//                             Text(
//                               " ${widget.snap.data!.docs[index].data()["Type Insect"]}",
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.location_on,
//                               color: '${widget.snap.data!.docs[index].data()["statusReport"]}' ==
//                                       '0'
//                                   ? pendingColor
//                                   : '${widget.snap.data!.docs[index].data()["statusReport"]}' ==
//                                           '1'
//                                       ? acceptColor
//                                       : rejectColor,
//                             ),
//                             SizedBox(
//                               width: 230,
//                               child: Text(
//                                 "${widget.snap.data!.docs[index].data()["Adress"]}",
//                                 maxLines: 1,
//                                 softWrap: true,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ],
//                         ),
//                         '${widget.snap.data!.docs[index].data()["statusReport"]}' ==
//                                 '0'
//                             ? const Row(
//                                 children: [
//                                   Icon(
//                                     Icons.timelapse_outlined,
//                                     color: pendingColor,
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   Text(
//                                     'البلاغ قيد الانتظار',
//                                     style: TextStyle(
//                                         color: pendingColor,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               )
//                             : '${widget.snap.data!.docs[index].data()["statusReport"]}' ==
//                                     '1'
//                                 ? const Row(
//                                     children: [
//                                       Icon(
//                                         Icons.check_circle_outline_rounded,
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         'تم قبول  البلاغ',
//                                         style: TextStyle(
//                                             color: acceptColor,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   )
//                                 : const Row(
//                                     children: [
//                                       Icon(
//                                         Icons.clear,
//                                         color: rejectColor,
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         'تم رفض البلاغ',
//                                         style: TextStyle(
//                                             color: rejectColor,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ButtonWidget(
//                               side: const BorderSide(
//                                   color: pendingColor,
//                                   style: BorderStyle.solid),
//                               icon: Icons.edit,
//                               colorIcon: pendingColor,
//                               colorText: pendingColor,
//                               child: "تعديل  ",
//                               onPressed: () {
//                                 Navigator.pushNamed(
//                                   context,
//                                   '/EditInstarctionScreen',
//                                   arguments: [
//                                     '${widget.snap.data!.docs[index].data()["id"]}',
//                                     '${widget.snap.data!.docs[index].data()["Adress"]}',
//                                     '${widget.snap.data!.docs[index].data()["Details Instraction"]}',
//                                     '${widget.snap.data!.docs[index].data()["imageLink"]}'
//                                   ],
//                                 );
//                                 print(
//                                     '${widget.snap.data!.docs[index].data()["id"]}');
//                               },
//                             ),
//                             const SizedBox(
//                               width: 15,
//                             ),
//                             ButtonWidget(
//                               side: const BorderSide(
//                                   style: BorderStyle.solid, color: rejectColor),
//                               icon: Icons.delete,
//                               colorIcon: rejectColor,
//                               colorText: rejectColor,
//                               child: "حذف ",
//                               onPressed: () {
//                                 setState(() {});
//                                 deleteReport(
//                                     '${widget.snap.data!.docs[index].data()["id"]}');
//                                 print(
//                                     '${widget.snap.data!.docs[index].data()["id"]}');
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         // clipBehavior: Clip.antiAlias,
//                         width: 70,
//                         height: 200,
//                         color: '${widget.snap.data!.docs[index].data()["statusReport"]}' ==
//                                 '0'
//                             ? pendingColor
//                             : '${widget.snap.data!.docs[index].data()["statusReport"]}' ==
//                                     '1'
//                                 ? acceptColor
//                                 : rejectColor,
//                         child: '${widget.snap.data!.docs[index].data()["statusReport"]}' ==
//                                 '0'
//                             ? const Icon(
//                                 Icons.timelapse_rounded,
//                                 color: backgroundColor,
//                                 size: 25,
//                               )
//                             : '${widget.snap.data!.docs[index].data()["statusReport"]}' ==
//                                     '1'
//                                 ? const Icon(
//                                     Icons.done_all,
//                                     color: backgroundColor,
//                                     size: 25,
//                                   )
//                                 : const Icon(
//                                     Icons.clear,
//                                     color: backgroundColor,
//                                     size: 25,
//                                   ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
