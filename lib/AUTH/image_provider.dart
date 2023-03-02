import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageProvider = Provider(
  (ref) => ImageProvider(firebaseStorage: FirebaseStorage.instance),
);

class ImageProvider {
  FirebaseStorage firebaseStorage;

  ImageProvider({required this.firebaseStorage});

  Future<String> downloadImage(String ref, File? file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String getURLlink = await taskSnapshot.ref.getDownloadURL();
    return getURLlink;
  }
}
