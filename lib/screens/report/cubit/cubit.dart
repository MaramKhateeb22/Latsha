import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mopidati/resources/util.dart';
import 'package:mopidati/screens/report/cubit/state.dart';
import 'package:uuid/uuid.dart';

enum statusReport {
  depinding,
  Accept,
  reject;
}

class AddReportCubit extends Cubit<AddReportState> {
  AddReportCubit() : super(AddReportInitalState());
  static AddReportCubit get(context) => BlocProvider.of(context);

  final formkey = GlobalKey<FormState>();
  TextEditingController AdressController = TextEditingController();
  TextEditingController nameInsectController = TextEditingController();
  Uint8List? image;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final uuid = const Uuid().v4();

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = storage.ref().child(childName).child('${uuid}jpg');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void selectImage(context) async {
    Uint8List img = await pickImage(ImageSource.gallery, context);

    image = img;
    emit(SelectImageState());
  }

  Future<String> saveData(context, LatLng point) async {
    String resp = "Some Error Occurred";
    try {
      emit(AddReportLoadingState());
      if (formkey.currentState?.validate() ?? false) {
        String imagUrl = await uploadImageToStorage('ReportImage', image!);
        // await FirebaseFirestore.instance.collection('markers').add(locationMap);
        statusReport statusdepending = statusReport.depinding;
        int statusIndex = statusReport.depinding.index;

        final uuid = const Uuid().v4();
        await FirebaseFirestore.instance.collection("Reports").doc(uuid).set({
          'id': uuid,
          'Type Insect': nameInsectController.text,
          'Adress': AdressController.text,
          'imageLink': imagUrl,
          'location': point.toString(),
          'statusReport': statusIndex,
          'idUser': FirebaseAuth.instance.currentUser!.uid,
          'createdAt': Timestamp.now(),
        });
        // print(point);
        // 'statusReport': statusdepending.toString().split('.').last,
        // 'statusReport': statusReport.i,
        // 'location': point,
        clearForm();
        emit(AddReportSuccessState());

        //بدي أظهر للمستخدم تم الارسال بنجاج هنا
        // Navigator.pushNamedAndRemoveUntil(
        //   context,
        //   '/allCategory', // الصفحة التي ترغب في الانتقال إليها
        //   ModalRoute.withName(
        //       '/home'), // '/HomePage' هو اسم المسار للصفحة التي تريد البقاء في المكدس
        // );
        print("Success submit");
      } else {
        emit(
          AddReportErrorState(error: 'Field Required'),
        );

        print('non fire store');
      }
      resp = 'Success';
    } catch (err) {
      resp = err.toString();
      emit(AddReportErrorState(error: resp));
    }
    return resp;
  }

  void clearForm() {
    nameInsectController.clear();
    AdressController.clear();

    image = null;
    emit(ClearFormState());
    // webImage = Uint8List(8);
  }
}
