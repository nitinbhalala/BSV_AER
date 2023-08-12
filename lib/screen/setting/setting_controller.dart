import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingController extends GetxController {
  bool forIos = false;
  File? userimage;
  bool selectimage = false;
  final picker = ImagePicker();
  var token;

  @override
  void onInit() {
    //  getLocalData();
    super.onInit();
  }

  void showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              getImage(true);
              Navigator.pop(context);
            },
            child: const Text(
              'Upload Image',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF282B3D)),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              getImage(false);
            },
            child: const Text('Camera',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF282B3D))),
          ),
        ],
      ),
    );
  }

  Future getImage(bool status) async {
    final pickedFile = await picker.pickImage(
        source: status ? ImageSource.gallery : ImageSource.camera);
    if (pickedFile != null) {
      selectimage = true;
      userimage = File(pickedFile.path);
      update();
    } else {
      // showMsg(context, msg: 'Please Select Image', color: Colors.red);
    }
  }
}
