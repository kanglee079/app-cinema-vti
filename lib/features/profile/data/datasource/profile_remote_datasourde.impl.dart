import 'dart:io';

import 'package:app_cinema/features/auths/domain/entities/user_entity.dart';
import 'package:app_cinema/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<UserEntity?> getUserProfile() async {
    try {
      final uid = auth.currentUser?.uid;
      if (uid == null) throw Exception("No user id found");

      final docSnapshot = await firestore.collection('users').doc(uid).get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        return UserEntity.fromMap(docSnapshot.data()!);
      } else {
        throw Exception("User does not exist");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<UserEntity?> updateUserProfile(UserEntity user) async {
    try {
      final uid = auth.currentUser?.uid;
      if (uid == null) throw Exception("No user id found");

      await firestore.collection('users').doc(uid).update(user.toMap());
    } catch (e) {
      print(e);
      rethrow;
    }
    return null;
  }

  @override
  Future<UserEntity?> updateUserProfileImage(
      UserEntity user, File imageFile) async {
    try {
      final uid = auth.currentUser?.uid;
      if (uid == null) throw Exception("No user id found");

      // Upload image to Firebase Storage
      var fileRef = storage.ref().child("user_avatars/$uid.jpg");
      await fileRef.putFile(imageFile);
      var imageUrl = await fileRef.getDownloadURL();

      // Update user profile with new image URL
      await firestore
          .collection('users')
          .doc(uid)
          .update({'avatarUrl': imageUrl});

      // Return updated user with new image URL
      return user.copyWith(avatarUrl: imageUrl);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
