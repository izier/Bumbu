import 'package:video_player/video_player.dart';

class VideoService {
  Future<VideoPlayerController> initialize(String url) async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await controller.initialize();
    return controller;
  }
}
