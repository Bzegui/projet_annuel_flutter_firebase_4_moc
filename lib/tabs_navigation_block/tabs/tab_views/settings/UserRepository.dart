import 'dart:io';
import 'package:authentication_repository/authentication_repository_exports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> saveUserProfile(User user, File? imageFile) async {
    try {
      // Sauvegarder les informations de l'utilisateur sur Firestore.
      final userDocument = _firestore.collection('users').doc();
      await userDocument.set({
        'first_name': user.firstName,
        'last_name': user.name,
        'date_of_birth': user.dateOfBirth,
      });

      // Télécharger la photo de profil sur Firebase Storage si une image est sélectionnée.
      if (imageFile != null) {
        final imageRef = _firebaseStorage.ref().child('profile_images').child(userDocument.id);
        final uploadTask = imageRef.putFile(imageFile);
        await uploadTask.whenComplete(() {});
        final downloadURL = await imageRef.getDownloadURL();
        // Enregistrez l'URL de téléchargement de l'image dans Firestore.
        await userDocument.update({'profile_image_url': downloadURL});
      }
      return 'success'; // Retournez 'success' si la sauvegarde réussit.
    } catch (e) {
      return 'error'; // Retournez 'error' en cas d'erreur.
    }
  }

  Future<User?> getUserProfile(String userId) async {
    try {
      // Récupérez les informations du user depuis Firestore.
      final userDocument = await _firestore.collection('users').doc(userId).get();
      if (userDocument.exists) {
        final data = userDocument.data() as Map<String, dynamic>;
        return User(
          firstName: data['first_name'],
          name: data['last_name'],
          dateOfBirth: data['date_de_naissance'],
          id: data['id'],
          unique_identifier: data['contactId'],
          email: data['email']
          // Ajoutez d'autres propriétés si nécessaire.
        );
      } else {
        return null;
      }
    } catch (e) {
      return null; // En cas d'erreur, retournez null.
    }
  }
}
