import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:latlong2/latlong.dart';
import 'package:mopidati/screens/reverse/Edit/cubit/cubit.dart';
import 'package:mopidati/screens/reverse/edit/cubit/state.dart';
import 'package:mopidati/utiles/constants.dart';
import 'package:mopidati/widgets/message.dart';
import 'package:mopidati/widgets/my_button_widget.dart';
import 'package:mopidati/widgets/text_form_field.dart';

class EditReverseScreen extends StatefulWidget {
  const EditReverseScreen({super.key});

  @override
  State<EditReverseScreen> createState() => _EditReverseScreenState();
}

class _EditReverseScreenState extends State<EditReverseScreen> {
  Future<QuerySnapshot<Map<String, dynamic>>> initInsect() async {
    return await FirebaseFirestore.instance.collection("insects").get();
  }

  String? _selectedValue;
  final double _area = 0.0;
  final spacekey = GlobalKey<FormState>();
  LatLng? point;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as List?;
    String id = arguments![0];

    return BlocProvider(
      create: (context) {
        EditReverseCubit cubit = EditReverseCubit();
        cubit.nameInsectEditController.text = arguments[1];
        cubit.adressEditController.text = arguments[2];
        cubit.spaceEditController.text = arguments[3];
        return cubit;
      },
      child: BlocConsumer<EditReverseCubit, EditReverseState>(
        listener: (context, state) {
          if (state is EditReverseSuccessState) {
            Navigator.pushNamed(context, '/ReverseUser');
            message(context, 'تم التعديل بنجاح');
            FlutterToastr.show(
              ' تم التعديل  بنجاح ',
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
            appBar: AppBar(
              title: const Text('تعديل الحجز'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          context.read<EditReverseCubit>().image != null
                              ? SizedBox(
                                  child: Image.memory(
                                    context.read<EditReverseCubit>().image!,
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
                                          .read<EditReverseCubit>()
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
                    Form(
                      key: context.read<EditReverseCubit>().formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormFieldWidget(
                                yourController: context
                                    .read<EditReverseCubit>()
                                    .nameInsectEditController,
                                hintText: 'تعديل  اسم الحشرة ',
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
                          Form(
                            key: spacekey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextFormFieldWidget(
                                  onChanged: (newValue) {
                                    // setState(() {
                                    //   newValue = _selectedValue;
                                    // });
                                  },
                                  yourController: context
                                      .read<EditReverseCubit>()
                                      .spaceEditController,
                                  hintText:
                                      'أدخل  المساحة التقريبية مقدرة بال كم ',
                                  // validator: (p0) {},
                                  keyboardType: TextInputType.number),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormFieldWidget(
                                yourController: context
                                    .read<EditReverseCubit>()
                                    .adressEditController,
                                hintText: 'عدل المكان بالتفصيل',
                                // validator: (p0) {},
                                keyboardType: TextInputType.name),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        state is EditReverseLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ButtonWidget(
                                icon: Icons.timelapse_outlined,

                                side: const BorderSide(
                                    color: pColor), // color: sColor,
                                onPressed: () {
                                  context
                                      .read<EditReverseCubit>()
                                      .formkey
                                      .currentState!
                                      .validate();
                                  context
                                      .read<EditReverseCubit>()
                                      .saveDataReverse(context, id);
                                },
                                child: 'حجز ',
                              ),
                        FutureBuilder(
                          future: initInsect(),
                          builder: (context, snapshot) => ButtonWidget(
                            colorText: Colors.red,
                            child: 'حذف',
                            onPressed: () {
                              context.read<EditReverseCubit>().clearForm();
                            },
                            icon: Icons.delete,
                            colorIcon: Colors.red,
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ],
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
