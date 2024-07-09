import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

class UploadImage {
  Future<String> uploadImage(File image, String filename) async {
    Reference ref = _storage.ref().child(filename).child('${DateTime.now()}');
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
