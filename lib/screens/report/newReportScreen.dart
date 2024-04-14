import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:latlong2/latlong.dart';
import 'package:mopidati/screens/report/cubit/cubit.dart';
import 'package:mopidati/screens/report/cubit/state.dart';
import 'package:mopidati/screens/report/mapReport/mapReport.dart';
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
    // LatLng selectedPoint;
    //     ModalRoute.of(context)?.settings.arguments as LatLng?;
    late LatLng point;
    // if (ModalRoute.of(context)?.settings.arguments != null) {
    //   LatLng? point = ModalRoute.of(context)!.settings.arguments as LatLng?;
    // } else {
    //   if (ModalRoute.of(context)?.settings.arguments == null) {
    //     point = const LatLng(0, 0);
    //     print(point);
    //     // استخدام القيمة point بشكل آمن هنا
    //   }
    // }
    // LatLng? point = ModalRoute.of(context)?.settings.arguments as LatLng;
    // if (route!.settings.arguments != null) {
    //   point = route.settings.arguments as LatLng;
    //   print(point);
    // } else {
    //   // هنا، يمكنك تعيين قيمة افتراضية لـ point أو طرح خطأ.
    //   point = const LatLng(0, 0);
    //   print(point); // كقيمة افتراضية. ضع أي قيمة تريدها.
    // }
    // var point = ModalRoute.of(context)?.settings.arguments as LatLng;
    return BlocProvider(
      create: (context) => AddReportCubit(),
      child: BlocConsumer<AddReportCubit, AddReportState>(
        listener: (context, state) {
          if (state is AddReportSuccessState) {
            Navigator.pushNamed(context, '/ReportUser');
            message(context, 'تم إرسال البلاغ بنجاح');
            FlutterToastr.show(
              ' تم إرسال البلاغ بنجاح ',
              context,
              position: FlutterToastr.bottom,
              duration: FlutterToastr.lengthLong,
              backgroundColor: backgroundColor,
              textStyle: const TextStyle(color: pColor),
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
                                      'اختر صورة الحشرة',
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
                      onPressed: () async {
                        // في الشاشة الأولى
                        final selectedPoint = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MapReport(),
                            // settings: RouteSettings(arguments: selectedPoint),
                          ),
                        );
                        if (selectedPoint != null) {
                          point = selectedPoint
                              as LatLng; // هنا تستقبل البيانات من الصفحة B
                        } else {
                          point = const LatLng(0.0, 0.0);
                          // تعامل مع حالة أنه لم يتم تمرير أي بيانات
                        }

// هنا يمكنك استخدام selectedPoint بعد إغلاق الشاشة الثانية
// على سبيل المثال، يمكنك تحديث حالة الشاشة الأولى بالبيانات التي تم تمريرها

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const MapReport(),
                        //   ),
                        // );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           const MapReport()), // استبدال MapReverseScreen() بالويدجت الخاص بالصفحة التي ترغب بالانتقال إليها
                        // );

                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   '/MapReport', // الصفحة التي ترغب في الانتقال إليها
                        //   ModalRoute.withName(
                        //       '/home'), // '/HomePage' هو اسم المسار للصفحة التي تريد البقاء في المكدس
                        // );
                      },
                      child: const Text(
                          'حدد المكان المنتشرة فيه الحشرة من الخريطة'),
                    ),
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
                                if (point == null) {
                                  // تحقق من أن المستخدم لم يحدد الموقع
                                  // عرض رسالة التنبيه
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('تنبيه'),
                                        content: const Text(
                                            'الرجاء تحديد الموقع أولاً'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('حسنًا'),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // لإغلاق الحوار
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  context.read<AddReportCubit>().image == null
                                      ? message(context,
                                          ' أرفع صورة  عن الحشرة من فضلك قبل الارسال')
                                      : null;
                                  // احفظ البيانات باستخدام Cubit
                                  context
                                      .read<AddReportCubit>()
                                      .saveData(context, point);
                                }
                                // context
                                //     .read<AddReportCubit>()
                                //     .saveData(context, point);
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
