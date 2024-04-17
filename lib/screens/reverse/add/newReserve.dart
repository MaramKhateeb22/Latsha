import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:latlong2/latlong.dart';
import 'package:mopidati/screens/reverse/add/cubit/cubit.dart';
import 'package:mopidati/screens/reverse/add/cubit/state.dart';
import 'package:mopidati/screens/reverse/mapReveerse/mapReverse.dart';
import 'package:mopidati/utiles/constants.dart';
import 'package:mopidati/widgets/message.dart';
import 'package:mopidati/widgets/my_button_widget.dart';
import 'package:mopidati/widgets/text_form_field.dart';

class NewReverseScreen extends StatefulWidget {
  const NewReverseScreen({super.key});

  @override
  State<NewReverseScreen> createState() => _NewReverseScreenState();
}

class _NewReverseScreenState extends State<NewReverseScreen> {
  Future<QuerySnapshot<Map<String, dynamic>>> initInsect() async {
    return await FirebaseFirestore.instance.collection("insects").get();
  }

  String? _selectedValue;
  final double _area = 0.0;
  final spacekey = GlobalKey<FormState>();
  LatLng? point;

  @override
  Widget build(BuildContext context) {
    // final route = ModalRoute.of(context);
    // LatLng point;
    // if (route != null && route.settings.arguments != null) {
    //   point = route.settings.arguments as LatLng;
    // } else {
    //   // هنا، يمكنك تعيين قيمة افتراضية لـ point أو طرح خطأ.
    //   point = const LatLng(0, 0); // كقيمة افتراضية. ضع أي قيمة تريدها.
    // }
    return BlocProvider(
      create: (context) => AddReverseCubit(),
      child: BlocConsumer<AddReverseCubit, AddReverseState>(
        listener: (context, state) {
          if (state is AddReverseSuccessState) {
            Navigator.pushNamed(context, '/ReverseUser');
            message(context, 'تم الحجز بنجاح');
            FlutterToastr.show(
              ' تم الحجز  بنجاح ',
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
                          context.read<AddReverseCubit>().image != null
                              ? SizedBox(
                                  child: Image.memory(
                                    context.read<AddReverseCubit>().image!,
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
                                          .read<AddReverseCubit>()
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
                        final selectedPoint = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MapReverse(),
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
                    FutureBuilder<QuerySnapshot<Map<String, dynamic>?>>(
                      future: initInsect(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (snapshot.hasData) {
                          // تحويل البيانات إلى قائمة من DropdownMenuItem
                          List<DropdownMenuItem<String>> insectItems = snapshot
                              .data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> insectData =
                                document.data()! as Map<String, dynamic>;
                            String insectName = insectData[
                                'name']; // افترض أن العمود يُدعى 'name'
                            return DropdownMenuItem<String>(
                              value: insectName,
                              child: Text(insectName),
                            );
                          }).toList();

                          return DropdownButton<String>(
                            icon: const Icon(Icons.arrow_drop_down_outlined),
                            dropdownColor: backgroundColor,
                            value: _selectedValue,
                            hint: const Text(" اختر نوع الحشرة المنتشرة عندك "),
                            items: insectItems,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedValue = newValue;
                              });
                            },
                          );
                        } else {
                          // يمكنك عرض رسالة أو ويدجت آخر هنا إذا لم تكن هناك بيانات
                          return const Text("لا يوجد بيانات.");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: context.read<AddReverseCubit>().formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormFieldWidget(
                                yourController: context
                                    .read<AddReverseCubit>()
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
                                      .read<AddReverseCubit>()
                                      .spaceController,
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
                                    .read<AddReverseCubit>()
                                    .adressController,
                                hintText: 'أدخل المكان بالتفصيل',
                                // validator: (p0) {},
                                keyboardType: TextInputType.name),
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 20.0),
                          //   child: TextFormFieldWidget(
                          //       yourController: context
                          //           .read<AddReverseCubit>()
                          //           .numberPhoneController,
                          //       hintText: 'أدخل  رقمك الجوال',
                          //       validator: (value) {
                          //         if (value.length < 10) {
                          //           return 'يجب أن يكون طول الرقم 10 أرقام على الأقل  ';
                          //         }
                          //       },
                          // validator: (p0) {},
                          // keyboardType: TextInputType.phone),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        state is AddReverseLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ButtonWidget(
                                icon: Icons.timelapse_outlined,

                                side: const BorderSide(
                                    color: pColor), // color: sColor,
                                onPressed: () {
                                  context
                                      .read<AddReverseCubit>()
                                      .formkey
                                      .currentState!
                                      .validate();
                                  context
                                      .read<AddReverseCubit>()
                                      .saveDataReverse(context, point);
                                },
                                child: 'حجز ',
                              ),
                        FutureBuilder(
                          future: initInsect(),
                          builder: (context, snapshot) => ButtonWidget(
                            child: 'التكلفة',
                            onPressed: () {
                              spacekey.currentState?.validate();
                              if (_selectedValue == null) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          const Text('يرجى اختيار نوع الحشرة'),
                                      content: const Text(
                                          'يجب عليك اختيار نوع الحشرة أولاً قبل حساب التكلفة.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('حسناً'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                int area = int.parse((context
                                        .read<AddReverseCubit>()
                                        .spaceController)
                                    .text);
                                int priceSpray = int.parse(snapshot.data!.docs
                                    .firstWhere((element) =>
                                        element.data()['name'] ==
                                        _selectedValue)['priceSpray']);
                                int totalCost = area * priceSpray;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(" تكلفة الرش"),
                                      content: Text(
                                          ":تكلفة الرش التقريبية هي $totalCost"
                                          '  ل.س'),
                                      actions: [
                                        TextButton(
                                          child: const Text("موافق"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            icon: Icons.attach_money_sharp,
                            colorIcon: pColor,
                            side: const BorderSide(color: pColor),
                          ),
                        ),
                        FutureBuilder(
                          future: initInsect(),
                          builder: (context, snapshot) => ButtonWidget(
                            colorText: Colors.red,
                            child: 'حذف',
                            onPressed: () {
                              context.read<AddReverseCubit>().clearForm();
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
