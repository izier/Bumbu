import '../data_sources/remote/firebase/feed_remote_ds.dart';

class FeedRepositoryImpl {
  final FeedRemoteDataSource remote;

  FeedRepositoryImpl(this.remote);

  Future<List<Map<String, dynamic>>> getFeed() async {
    return remote.getFeed();
  }
}
