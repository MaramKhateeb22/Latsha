import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:latlong2/latlong.dart';
import 'package:mopidati/screens/mapReport/mapReport.dart';
import 'package:mopidati/screens/report/cubit/cubit.dart';
import 'package:mopidati/screens/report/cubit/state.dart';
import 'package:mopidati/utiles/constants.dart';
import 'package:mopidati/widgets/message.dart';
import 'package:mopidati/widgets/my_button_widget.dart';
import 'package:mopidati/widgets/text_form_field.dart';

class NewReportScreen extends StatefulWidget {
  const NewReportScreen({super.key});

  @override
  State<NewReportScreen> createState() => _NewReportScreenState();
}

class _NewReportScreenState extends State<NewReportScreen> {
  Future<QuerySnapshot<Map<String, dynamic>>> initInsect() async {
    return await FirebaseFirestore.instance.collection("insects").get();
  }

  // String? _selectedValue;
  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    LatLng point;
    if (route != null && route.settings.arguments != null) {
      point = route.settings.arguments as LatLng;
    } else {
      // هنا، يمكنك تعيين قيمة افتراضية لـ point أو طرح خطأ.
      point = const LatLng(0, 0); // كقيمة افتراضية. ضع أي قيمة تريدها.
    }
    // var point = ModalRoute.of(context)?.settings.arguments as LatLng;
    return BlocProvider(
      create: (context) => AddReportCubit(),
      child: BlocConsumer<AddReportCubit, AddReportState>(
        listener: (context, state) {
          if (state is AddReportSuccessState) {
            Navigator.pushNamed(context, '/home');
            message(context, 'تم إرسال البلاغ بنجاح');
            FlutterToastr.show(
              ' تم إرسال البلاغ بنجاح ',
              context,
              position: FlutterToastr.bottom,
              duration: FlutterToastr.lengthLong,
              backgroundColor: backgroundColor,
              textStyle: const TextStyle(color: Colors.white),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          context.read<AddReportCubit>().image != null
                              ? SizedBox(
                                  child: Image.memory(
                                    context.read<AddReportCubit>().image!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: pColor,
                                  ),
                                  width: 300,
                                  height: 300,
                                  child: TextButton(
                                    onPressed: () {
                                      context
                                          .read<AddReportCubit>()
                                          .selectImage(context);
                                    },
                                    child: const Text(
                                      'Choose The  image insect',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                       
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/MapReport', // الصفحة التي ترغب في الانتقال إليها
                          ModalRoute.withName(
                              '/home'), // '/HomePage' هو اسم المسار للصفحة التي تريد البقاء في المكدس
                        );
                      },
                      child: const Text(
                          'حدد المكان المنتشرة فيه الحشرة من الخريطة'),
                    ),

                    // FutureBuilder<QuerySnapshot<Map<String, dynamic>?>>(
                    //   future: initInsect(),
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<QuerySnapshot> snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return const Center(
                    //           child: CircularProgressIndicator());
                    //     }
                    //     if (snapshot.hasError) {
                    //       return Center(
                    //           child: Text('Error: ${snapshot.error}'));
                    //     }
                    //     if (snapshot.hasData) {
                    //       // تحويل البيانات إلى قائمة من DropdownMenuItem
                    //       List<DropdownMenuItem<String>> insectItems = snapshot
                    //           .data!.docs
                    //           .map((DocumentSnapshot document) {
                    //         Map<String, dynamic> insectData =
                    //             document.data()! as Map<String, dynamic>;
                    //         String insectName = insectData[
                    //             'name']; // افترض أن العمود يُدعى 'name'
                    //         return DropdownMenuItem<String>(
                    //           value: insectName,
                    //           child: Text(insectName),
                    //         );
                    //       }).toList();

                    //       return DropdownButton<String>(
                    //         icon: const Icon(Icons.arrow_drop_down_outlined),
                    //         dropdownColor: backgroundColor,
                    //         value: _selectedValue,
                    //         hint: const Text("اختر حشرة"),
                    //         items: insectItems,
                    //         onChanged: (newValue) {
                    //           setState(() {
                    //             _selectedValue = newValue;
                    //           });
                    //         },
                    //       );
                    //     } else {
                    //       // يمكنك عرض رسالة أو ويدجت آخر هنا إذا لم تكن هناك بيانات
                    //       return const Text("لا يوجد بيانات.");
                    //     }
                    //   },
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: context.read<AddReportCubit>().formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormFieldWidget(
                                yourController: context
                                    .read<AddReportCubit>()
                                    .nameInsectController,
                                hintText: 'أدخل  اسم الحشرة ',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }
                                },
                                keyboardType: TextInputType.name),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormFieldWidget(
                                yourController: context
                                    .read<AddReportCubit>()
                                    .AdressController,
                                hintText: 'أدخل المكان بالتفصيل',
                                // validator: (p0) {},
                                keyboardType: TextInputType.name),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: state is AddReportLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ButtonWidget(
                              child: const Text('إبلاغ'),
                              onPressed: () {
                                context
                                    .read<AddReportCubit>()
                                    .saveData(context, point);
                              }),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
