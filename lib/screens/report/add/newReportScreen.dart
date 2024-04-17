import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:latlong2/latlong.dart';
import 'package:mopidati/screens/report/add/cubit/cubit.dart';
import 'package:mopidati/screens/report/add/cubit/state.dart';
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

  @override
  Widget build(BuildContext context) {
    LatLng? point;
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
                      },
                      child: point == null
                          ? const Text('حدد مكانك  من  الخريطة')
                          : const Text('تم التحديد ✔'),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          state is AddReportLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ButtonWidget(
                                  child: 'إبلاغ',
                                  side: const BorderSide(color: pColor),
                                  icon: Icons.telegram,
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
                                      context.read<AddReportCubit>().image ==
                                              null
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
                          ButtonWidget(
                            icon: Icons.delete,
                            colorIcon: Colors.red,
                            colorText: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            child: 'حذف',
                            onPressed: () {
                              context.read<AddReportCubit>().clearForm();
                            },
                          ),
                        ],
                      ),
                    ),
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
