// import 'dart:io';

// import '../repositories/user_repository.dart';
// import '../../domain/entities/result.dart';
// import '../../domain/entities/user.dart';

// class DummyUserRepo implements UserRepository {
//   @override
//   Future<Result<User>> createUser(
//       {required String uid,
//       required String email,
//       required String name,
//       String? photoUrl,
//       int balance = 0}) {
//     // TODO: implement createUser
//     throw UnimplementedError();
//   }

//   @override
//   Future<Result<User>> getUser({required String uid}) async {
//     await Future.delayed(Duration(seconds: 1));
//     return Result.success(User(uid: uid, email: 'dummy@mail.com', name: 'dummy'));
//   }

//   @override
//   Future<Result<int>> getUserBalance({required String uid}) {
//     // TODO: implement getUserBalance
//     throw UnimplementedError();
//   }

//   @override
//   Future<Result<User>> updateUser({required User user}) {
//     // TODO: implement updateUser
//     throw UnimplementedError();
//   }

//   @override
//   Future<Result<User>> updateUserBalance(
//       {required String uid, required int balance}) {
//     // TODO: implement updateUserBalance
//     throw UnimplementedError();
//   }

//   @override
//   Future<Result<User>> uploadPP({required User user, required File imageFile}) {
//     // TODO: implement uploadPP
//     throw UnimplementedError();
//   }
// }
