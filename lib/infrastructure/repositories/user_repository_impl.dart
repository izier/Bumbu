// import '../../shared/models/user_model.dart';
// import '../data_sources/remote/firebase/user_remote_ds.dart';
// import '../mappers/user_mapper.dart';
//
// class UserRepositoryImpl {
//   final UserRemoteDataSource remote;
//
//   UserRepositoryImpl(this.remote);
//
//   Future<UserModel?> getUser(String id) async {
//     final data = await remote.getUser(id);
//     if (data == null) return null;
//
//     return UserMapper.fromMap(data);
//   }
// }
