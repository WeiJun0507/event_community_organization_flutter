import 'dart:io';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;

  Future uploadImageToFirebase(File? imageFile) async {
    if (imageFile != null) {
      Reference firebaseStorageRef = _storage.ref().child('event/${basename(imageFile.path)}');
      TaskSnapshot result = await firebaseStorageRef.putFile(imageFile);
      var downloadUrl = await result.ref.getDownloadURL();
      return downloadUrl;
    } else {
      return null;
    }
  }

  Future uploadImageToFirebasePost(File? imageFile) async {
    if (imageFile != null) {
      Reference firebaseStorageRef = _storage.ref().child('post/${basename(imageFile.path)}');
      TaskSnapshot result = await firebaseStorageRef.putFile(imageFile);
      var downloadUrl = await result.ref.getDownloadURL();
      return downloadUrl;
    } else {
      return null;
    }
  }

}