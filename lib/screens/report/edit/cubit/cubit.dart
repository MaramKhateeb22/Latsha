import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mopidati/resources/util.dart';
import 'package:mopidati/screens/report/edit/cubit/state.dart';
import 'package:uuid/uuid.dart';

class EditReportCubit extends Cubit<EditReportState> {
  EditReportCubit() : super(EditReportInitalState());
  static EditReportCubit get(context) => BlocProvider.of(context);

  final formkey = GlobalKey<FormState>();
  TextEditingController adressEditController = TextEditingController();
  TextEditingController nameInsectEditController = TextEditingController();
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
    emit(SelectimageState());
  }

  Future<String> editsaveData(context, String editReportId) async {
    String resp = "Some Error Occurred";
    try {
      emit(EditReportLoadingState());
      if (formkey.currentState?.validate() ?? false) {
        String imagUrl = await uploadImageToStorage('ReportImage', image!);
        await FirebaseFirestore.instance
            .collection("Reports")
            .doc(editReportId)
            .update(
          {
            'Type Insect': nameInsectEditController.text,
            'Adress': adressEditController.text,
            'imageLink': imagUrl,
            'createdAt': Timestamp.now(),
          },
        );
        clearForm();
        emit(EditReportSuccessState());
        print("Success submit");
      } else {
        emit(
          EditReportErrorState(error: 'Field Required'),
        );
        print('non fire store');
      }
      resp = 'Success';
    } catch (err) {
      resp = err.toString();
      emit(EditReportErrorState(error: resp));
    }
    return resp;
  }

  void clearForm() {
    nameInsectEditController.clear();
    adressEditController.clear();
    image = null;
    emit(ClearformState());
  }
}
