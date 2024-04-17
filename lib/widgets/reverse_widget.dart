// import 'package:flutter/material.dart';
// import 'package:mopidati/utiles/constants.dart';
// import 'package:mopidati/widgets/my_button_widget.dart';

// class ReverseListView extends StatefulWidget {
//   final AsyncSnapshot snap;
//   VoidCallbackAction onPresseddelete;
//   ReverseListView(
//       {
//       // this.snapshot,
//       super.key,
//       required this.snap,
//       required this.onPresseddelete});

//   @override
//   State<ReverseListView> createState() => _ReverseListViewState();
// }

// class _ReverseListViewState extends State<ReverseListView> {
//   @override
//   Widget build(BuildContext context) {
    // return ListView.builder(
    //   padding: const EdgeInsets.symmetric(horizontal: 7),
    //   itemCount: widget.snap.data?.docs.length ?? 0,
    //   itemBuilder: (context, index) {
    //     return Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
    //       child: Card(
    //         clipBehavior: Clip.antiAlias,
    //         color: backgroundColor,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(15),
    //           side: BorderSide(
    //             color: '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                     '0'
    //                 ? pendingColor
    //                 : '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                         '1'
    //                     ? acceptColor
    //                     : '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                             '2'
    //                         ? rejectColor
    //                         : doneColor, // لون الحدود
    //             // width: 2.0, // عرض الحدود
    //           ),
    //         ),
    //         margin: const EdgeInsets.symmetric(vertical: 4),
    //         child: Padding(
    //           padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(0.0),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Icon(Icons.bug_report,
    //                             color: '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                                     '0'
    //                                 ? pendingColor
    //                                 : '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                                         '1'
    //                                     ? acceptColor
    //                                     : '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                                             '2'
    //                                         ? rejectColor
    //                                         : doneColor),
    //                         Text(
    //                           "${widget.snap.data!.docs[index].data()["Type Insect"]}",
    //                         ),
    //                       ],
    //                     ),
    //                     Row(
    //                       children: [
    //                         Icon(Icons.location_on,
    //                             color: '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                                     '0'
    //                                 ? pendingColor
    //                                 : '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                                         '1'
    //                                     ? acceptColor
    //                                     : '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                                             '2'
    //                                         ? rejectColor
    //                                         : doneColor),
    //                         SizedBox(
    //                           width: 230,
    //                           child: Text(
    //                             "${widget.snap.data!.docs[index].data()["Adress"]}",
    //                             maxLines: 1,
    //                             softWrap: true,
    //                             overflow: TextOverflow.ellipsis,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                             '0'
    //                         ? const Row(
    //                             children: [
    //                               Icon(
    //                                 Icons.timelapse_outlined,
    //                                 color: pendingColor,
    //                               ),
    //                               SizedBox(
    //                                 width: 5,
    //                               ),
    //                               Text(
    //                                 'الحجز قيد الانتظار',
    //                                 style: TextStyle(
    //                                     color: pendingColor,
    //                                     fontWeight: FontWeight.bold),
    //                               ),
    //                             ],
    //                           )
    //                         : '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                                 '1'
    //                             ? const Row(
    //                                 children: [
    //                                   Icon(
    //                                     color: acceptColor,
    //                                     Icons.check_circle_outline_rounded,
    //                                   ),
    //                                   SizedBox(
    //                                     width: 5,
    //                                   ),
    //                                   Text(
    //                                     'تم قبول  الحجز',
    //                                     style: TextStyle(
    //                                         color: acceptColor,
    //                                         fontWeight: FontWeight.bold),
    //                                   ),
    //                                 ],
    //                               )
    //                             : '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                                     '2'
    //                                 ? const Row(
    //                                     children: [
    //                                       Icon(
    //                                         color: rejectColor,
    //                                         Icons.clear,
    //                                       ),
    //                                       SizedBox(
    //                                         width: 5,
    //                                       ),
    //                                       Text(
    //                                         'تم رفض  الحجز',
    //                                         style: TextStyle(
    //                                             color: rejectColor,
    //                                             fontWeight: FontWeight.bold),
    //                                       ),
    //                                     ],
    //                                   )
    //                                 : const Row(
    //                                     children: [
    //                                       Icon(
    //                                         Icons.done_all,
    //                                         color: doneColor,
    //                                       ),
    //                                       SizedBox(
    //                                         width: 5,
    //                                       ),
    //                                       Text(
    //                                         'تم الرش',
    //                                         style: TextStyle(
    //                                             color: doneColor,
    //                                             fontWeight: FontWeight.bold),
    //                                       ),
    //                                     ],
    //                                   ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         const SizedBox(
    //                           width: 27,
    //                         ),
    //                         ButtonWidget(
    //                             colorIcon: Colors.green,
    //                             colorText: Colors.green,
    //                             // backgroundColors: Colors.grey,
    //                             icon: Icons.edit,
    //                             onPressed: () {
    //                               print(widget.snap.data!.docs[index]
    //                                   .data()["id"]);
    //                             },
    //                             child: 'تعديل'),
    //                         const SizedBox(
    //                           width: 15,
    //                         ),
    //                         ButtonWidget(
    //                             colorIcon: Colors.red,
    //                             icon: Icons.delete,
    //                             colorText: Colors.red,
    //                             onPressed: () {
    //                               onPresseddelete() {}
    //                             },
    //                             // () {

    //                             // onPressedReject;
    //                             // setState(() {
    //                             //   deleteReverse(widget.snap.data!.docs[index]
    //                             //       .data()["id"]);
    //                             // });

    //                             // print(widget.snap.data!.docs[index]
    //                             //     .data()["id"]);

    //                             // print('تم الحذف الحجز');
    //                             // },
    //                             child: 'حذف'),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Column(
    //                 children: [
    //                   Container(
    //                     // clipBehavior: Clip.antiAlias,
    //                     width: 70,
    //                     height: 200,
    //                     color: '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                             '0'
    //                         ? pendingColor
    //                         : '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                                 '1'
    //                             ? acceptColor
    //                             : '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                                     '2'
    //                                 ? rejectColor
    //                                 : doneColor,
    //                     child: '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                             '0'
    //                         ? const Icon(
    //                             Icons.timelapse_rounded,
    //                             color: backgroundColor,
    //                             size: 25,
    //                           )
    //                         : '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                                 '1'
    //                             ? const Icon(
    //                                 Icons.check,
    //                                 color: backgroundColor,
    //                                 size: 25,
    //                               )
    //                             : '${widget.snap.data!.docs[index].data()["statusReverse"]}' ==
    //                                     '2'
    //                                 ? const Icon(
    //                                     Icons.clear,
    //                                     color: backgroundColor,
    //                                     size: 25,
    //                                   )
    //                                 : const Icon(
    //                                     Icons.done_all,
    //                                     color: backgroundColor,
    //                                     size: 25,
    //                                   ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
//   }
// }
