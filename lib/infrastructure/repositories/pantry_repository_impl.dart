import '../data_sources/remote/firebase/pantry_remote_ds.dart';
import '../data_sources/local/pantry_local_ds.dart';

class PantryRepositoryImpl {
  final PantryRemoteDataSource remote;
  final PantryLocalDataSource local;

  PantryRepositoryImpl({
    required this.remote,
    required this.local,
  });

  Future<List<Map<String, dynamic>>> getPantry(String userId) async {
    final remoteData = await remote.getPantry(userId);

    if (remoteData.isNotEmpty) {
      await local.savePantry(userId, remoteData);
      return remoteData;
    }

    final localData = await local.getPantry(userId);
    return localData ?? [];
  }
}
