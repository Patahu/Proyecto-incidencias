import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class DataBaseIncidentFirestore {
  final FirebaseStorage _firebaseFirestore;

  DataBaseIncidentFirestore({FirebaseStorage? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseStorage.instance;

  UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
