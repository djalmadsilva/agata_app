import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStoreDataBase {
  String? downloadURL;

  String? localLogo;

  FireStoreDataBase(String localLogo) {
    this.localLogo = localLogo;
  }

  Future getData() async {
    try {
      await downloadURLExample();
      return downloadURL;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<void> downloadURLExample() async {
    downloadURL = await FirebaseStorage.instance
        .ref()
        .child(localLogo!)
        .getDownloadURL();
  }
}
