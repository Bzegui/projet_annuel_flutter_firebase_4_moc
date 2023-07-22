import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../users_exports.dart';

class UsersRepository {
  UsersRemoteDataSource usersRemoteDataSource;

  UsersRepository({required this.usersRemoteDataSource});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  /// Get user with the provided [contactId].
  ///
  /// Throws a [] if an exception occurs.
  Stream<List<User>> getContactUserById({required String contactId}) {
    return usersRemoteDataSource.getContactUserById(contactId);
  }


  Future<String> saveUserProfile(User user, File? imageFile) async {
    try {

      final userDocument = _firestore.collection('users').doc();
      await userDocument.update({
        'name': user.name,
        'first_name': user.firstName,
        'birthDate': user.birthDate,
        'photo' : user.photo
      });

      if (imageFile != null) {
        final imageRef = _firebaseStorage.ref().child('profile_images').child(userDocument.id);
        final uploadTask = imageRef.putFile(imageFile);
        await uploadTask.whenComplete(() {});
        final downloadURL = await imageRef.getDownloadURL();
        await userDocument.update({'profile_image_url': downloadURL});
      }
      return 'success';
    } catch (e) {
      return 'error';
    }
  }

  Future<User?> getUserProfile(String userId) async {
    try {
      final userDocument = await _firestore.collection('users').doc(userId).get();
      if (userDocument.exists) {
        final data = userDocument.data() as Map<String, dynamic>;
        return User(
            firstName: data['first_name'],
            name: data['name'],
            birthDate: data['birthDate'],
            id: data['id'],
            email: data['email']
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}