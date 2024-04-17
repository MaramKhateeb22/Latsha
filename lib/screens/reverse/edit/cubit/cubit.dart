import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mopidati/resources/util.dart';
import 'package:mopidati/screens/reverse/edit/cubit/state.dart';
import 'package:uuid/uuid.dart';

class EditReverseCubit extends Cubit<EditReverseState> {
  EditReverseCubit() : super(EditReverseInitalState());
  static EditReverseCubit get(context) => BlocProvider.of(context);

  final formkey = GlobalKey<FormState>();
  TextEditingController adressEditController = TextEditingController();
  TextEditingController nameInsectEditController = TextEditingController();
  TextEditingController spaceEditController = TextEditingController();
  Uint8List? image;
  final FirebaseStorage storage = FirebaseStorage.instance;
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
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

  Future<String> saveDataReverse(context, String editReverseId) async {
    String resp = "Some Error Occurred";
    try {
      emit(EditReverseLoadingState());
      if (formkey.currentState?.validate() ?? false) {
        String imagUrl = await uploadImageToStorage('ReverseImage', image!);
        // await FirebaseFirestore.instance.collection('markers').Edit(locationMap);
        // statusReverse statusdepending = statusReverse.depinding;
        // int statusIndex = statusReverse.depinding.index;

        // final uuid = const Uuid().v4();
        await FirebaseFirestore.instance
            .collection("Reverses")
            .doc(editReverseId)
            .update({
          'Type Insect': nameInsectEditController.text,
          'Adress': adressEditController.text,
          'space': spaceEditController.text,
          'imageLink': imagUrl,
          'createdAt': Timestamp.now(),
        });
        clearForm();
        emit(EditReverseSuccessState());
        print("Success submit");
      } else {
        emit(
          EditReverseErrorState(error: 'Field Required'),
        );

        print('non fire store');
      }
      resp = 'Success';
    } catch (err) {
      resp = err.toString();
      emit(EditReverseErrorState(error: resp));
    }
    return resp;
  }

  void clearForm() {
    nameInsectEditController.clear();
    adressEditController.clear();
    spaceEditController.clear();
    image = null;
    emit(ClearFormState());
  }
}
