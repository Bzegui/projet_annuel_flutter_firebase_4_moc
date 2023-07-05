import 'package:equatable/equatable.dart';

/// {@template contact}
/// Contact model
///
/// {@endtemplate}
class Contact extends Equatable {
  /// {@macro contact}
  const Contact({
    required this.id,
    required this.contactId,
    this.name,
    this.email,
    this.photo,
  });

  /// The current contact's id.
  final String id;

  /// The current contact's contactId.
  final String contactId;

  /// The current contact's name (display name).
  final String? name;

  /// The current contact's email address.
  final String? email;

  /// contact photo URL.
  final String? photo;

  /// map for getting contact object from firestore.
  Map<String, dynamic> toMap() {
    return {
      'contactId': contactId,
      'name': name,
      'email': email,
      'photo': photo
    };
  }

  /// contact factory for getting contacts list from Firestore.
  factory Contact.fromFirestore(Map<String, dynamic> map, String id) {
    return Contact(
      id: id,
      contactId: map['contact_id'],
      name: map['name'],
      email: map['email'],
      photo: map['photo'],
    );
  }

  @override
  List<Object?> get props => [id, contactId, name, email, photo];
}