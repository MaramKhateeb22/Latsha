import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mopidati/resources/util.dart';
import 'package:mopidati/screens/reverse/add/cubit/state.dart';
import 'package:uuid/uuid.dart';

enum statusReverse {
  depinding,
  Accept,
  reject;
}

class AddReverseCubit extends Cubit<AddReverseState> {
  AddReverseCubit() : super(AddReverseInitalState());
  static AddReverseCubit get(context) => BlocProvider.of(context);

  final formkey = GlobalKey<FormState>();
  TextEditingController adressController = TextEditingController();
  TextEditingController nameInsectController = TextEditingController();
  TextEditingController spaceController = TextEditingController();
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

  Future<String> saveDataReverse(context, LatLng? point) async {
    String resp = "Some Error Occurred";
    try {
      emit(AddReverseLoadingState());
      if (formkey.currentState?.validate() ?? false) {
        String imagUrl = await uploadImageToStorage('ReverseImage', image!);
        // await FirebaseFirestore.instance.collection('markers').add(locationMap);
        statusReverse statusdepending = statusReverse.depinding;
        int statusIndex = statusReverse.depinding.index;

        final uuid = const Uuid().v4();
        await FirebaseFirestore.instance.collection("Reverses").doc(uuid).set({
          'id': uuid,
          'Type Insect': nameInsectController.text,
          'Adress': adressController.text,
          'space': spaceController.text,
          'imageLink': imagUrl,
          'location': point.toString(),
          'statusReverse': statusIndex,
          // 'numberPhone': numberPhoneController.text,
          'idUser': FirebaseAuth.instance.currentUser!.uid,
          'createdAt': Timestamp.now(),
        });

        clearForm();
        emit(AddReverseSuccessState());

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
          AddReverseErrorState(error: 'Field Required'),
        );

        print('non fire store');
      }
      resp = 'Success';
    } catch (err) {
      resp = err.toString();
      emit(AddReverseErrorState(error: resp));
    }
    return resp;
  }

  void clearForm() {
    nameInsectController.clear();
    adressController.clear();
    spaceController.clear();
    // numberPhoneController.clear();
    image = null;
    emit(ClearFormState());
    // webImage = Uint8List(8);
  }
}
