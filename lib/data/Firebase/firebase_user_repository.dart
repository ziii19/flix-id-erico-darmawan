import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../repositories/user_repository.dart';
import '../../domain/entities/result.dart';
import '../../domain/entities/user.dart';
import 'package:path/path.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseUserRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Result<User>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0}) async {
    CollectionReference<Map<String, dynamic>> users =
        _firebaseFirestore.collection('users');

    await users.doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'balance': balance,
    });

    DocumentSnapshot<Map<String, dynamic>> result = await users.doc(uid).get();

    if (result.exists) {
      return Result.success(User.fromJson(result.data()!));
    } else {
      return const Result.failed('failed to Create user data');
    }
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        _firebaseFirestore.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();

    if (result.exists) {
      return Result.success(User.fromJson(result.data()!));
    } else {
      return const Result.failed('User not found!');
    }
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) async {
    DocumentReference<Map<String, dynamic>> balance =
        _firebaseFirestore.doc('users/$uid');
    DocumentSnapshot<Map<String, dynamic>> result = await balance.get();

    if (result.exists) {
      return Result.success(result.data()!['balance']);
    } else {
      return const Result.failed('User not found');
    }
  }

  @override
  Future<Result<User>> updateUser({required User user}) async {
    try {
      DocumentReference<Map<String, dynamic>> users =
          _firebaseFirestore.doc('users/${user.uid}');
      await users.update(user.toJson());

      DocumentSnapshot<Map<String, dynamic>> result = await users.get();

      if (result.exists) {
        User updateUser = User.fromJson(result.data()!);

        if (updateUser == user) {
          return Result.success(updateUser);
        } else {
          return const Result.failed('Failed to update user data');
        }
      } else {
        return const Result.failed('Failed to update user data');
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? 'Failed to update user data');
    }
  }

  ///noted!!!!!!!!
  @override
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        _firebaseFirestore.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();

    if (result.exists) {
      await documentReference.update({'balance': balance});

      DocumentSnapshot<Map<String, dynamic>> updateResult =
          await documentReference.get();

      if (updateResult.exists) {
        User updateUser = User.fromJson(updateResult.data()!);
        // Verifikasi bahwa saldo telah diperbarui dengan benar
        if (updateUser.balance == balance) {
          return Result.success(updateUser);
        } else {
          // Objek Result yang gagal karena saldo tidak sama dengan yang diharapkan
          return const Result.failed('Failed to update user balance');
        }
      } else {
        // Objek Result yang gagal karena gagal mendapatkan data setelah pembaruan
        return const Result.failed('Failed to retrieve updated user balance');
      }
    } else {
      // Objek Result yang gagal karena pengguna tidak ditemukan
      return const Result.failed('User not found');
    }
  }

  @override
  Future<Result<User>> uploadPP(
      {required User user, required File imageFile}) async {
    String filename = basename(imageFile.path);

    Reference reference = FirebaseStorage.instance.ref().child(filename);

    try {
      await reference.putFile(imageFile);

      String downloadUrl = await reference.getDownloadURL();

      var updateResult =
          await updateUser(user: user.copyWith(photoUrl: downloadUrl));

      if (updateResult.isSuccess) {
        return Result.success(updateResult.resultValue!);
      } else {
        return Result.failed(updateResult.errorMessage!);
      }
    } catch (e) {
      return const Result.failed('Failed to upload profile picture');
    }
  }
}
