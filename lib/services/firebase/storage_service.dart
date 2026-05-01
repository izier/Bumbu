import 'dart:typed_data';
import 'firebase_service.dart';

class StorageService {
  final _storage = FirebaseService.storage;

  Future<String> uploadFile(String path, Uint8List bytes) async {
    final ref = _storage.ref().child(path);

    await ref.putData(bytes);

    return await ref.getDownloadURL();
  }

}
