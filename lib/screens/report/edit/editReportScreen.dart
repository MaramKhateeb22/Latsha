import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:mopidati/screens/report/Edit/cubit/cubit.dart';
import 'package:mopidati/screens/report/edit/cubit/state.dart';
import 'package:mopidati/utiles/constants.dart';
import 'package:mopidati/widgets/message.dart';
import 'package:mopidati/widgets/my_button_widget.dart';
import 'package:mopidati/widgets/text_form_field.dart';

class EditReportScreen extends StatefulWidget {
  const EditReportScreen({super.key});
  @override
  State<EditReportScreen> createState() => _EditReportScreenState();
}

class _EditReportScreenState extends State<EditReportScreen> {
  Future<QuerySnapshot<Map<String, dynamic>>> initInsect() async {
    return await FirebaseFirestore.instance.collection("insects").get();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as List?;
    String id = arguments![0];

    return BlocProvider(
      create: (context) {
        EditReportCubit cubit = EditReportCubit();
        cubit.nameInsectEditController.text = arguments[1];
        cubit.adressEditController.text = arguments[2];
        return cubit;
      },
      child: BlocConsumer<EditReportCubit, EditReportState>(
        listener: (context, state) {
          if (state is EditReportSuccessState) {
            Navigator.pushNamed(context, '/ReportUser');
            message(context, 'تم تعديل  البلاغ بنجاح');
            FlutterToastr.show(
              ' تم تعديل البلاغ بنجاح ',
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
            appBar: AppBar(
              title: const Text('تعديل البلاغ'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          context.read<EditReportCubit>().image != null
                              ? SizedBox(
                                  child: Image.memory(
                                    context.read<EditReportCubit>().image!,
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
                                          .read<EditReportCubit>()
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
                      height: 20,
                    ),
                    Form(
                      key: context.read<EditReportCubit>().formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormFieldWidget(
                                yourController: context
                                    .read<EditReportCubit>()
                                    .nameInsectEditController,
                                hintText: 'عدل  اسم الحشرة ',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }
                                },
                                keyboardType: TextInputType.name),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormFieldWidget(
                                yourController: context
                                    .read<EditReportCubit>()
                                    .adressEditController,
                                hintText: 'عدل المكان ',
                                // validator: (p0) {},
                                keyboardType: TextInputType.name),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          state is EditReportLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ButtonWidget(
                                  child: 'إبلاغ',
                                  side: const BorderSide(color: pColor),
                                  icon: Icons.telegram,
                                  onPressed: () {
                                    context.read<EditReportCubit>().image ==
                                            null
                                        ? message(context,
                                            ' أرفع صورة  عن الحشرة من فضلك قبل الارسال')
                                        : null;
                                    // احفظ البيانات باستخدام Cubit
                                    context
                                        .read<EditReportCubit>()
                                        .editsaveData(context, id);
                                  },
                                ),
                          ButtonWidget(
                            icon: Icons.delete,
                            colorIcon: Colors.red,
                            colorText: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            child: 'حذف',
                            onPressed: () {
                              context.read<EditReportCubit>().clearForm();
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
