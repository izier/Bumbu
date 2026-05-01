import 'firebase_service.dart';

class MessagingService {
  final _messaging = FirebaseService.messaging;

  Future<String?> getToken() async {
    return await _messaging.getToken();
  }

  Future<void> requestPermission() async {
    await _messaging.requestPermission();
  }
}
