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
    required this.name,
    this.email,
    this.photo,
  });

  /// The current contact's id.
  final String id;

  /// The current contact's contactId.
  final String contactId;

  /// The current contact's name (display name).
  final String name;

  /// The current contact's email address.
  final String? email;

  /// contact photo URL.
  final String? photo;

  /// contact factory for getting contacts list from Firestore.
  factory Contact.fromFirestore(Map<String, dynamic> map, String id) {
    return Contact(
      id: id,
      contactId: map['contactId'],
      name: map['name'],
    );
  }

  @override
  List<Object?> get props => [id, contactId, name];
}