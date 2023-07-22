import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.contactId,
    this.email,
    this.firstName,
    this.name,
    this.birthDate,
    this.photo,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's contactId.
  final String? contactId;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  final String? firstName;

  final String? birthDate;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  /// contact factory for getting contacts list from Firestore.
  factory User.fromFirestore(Map<String, dynamic> map, String id) {
    return User(
      id: id,
      contactId: map['contactId'],
      name: map['name'],
      email: map['email'],
      firstName: map['firstName'],
      birthDate: map['birthDate'],
      photo: map['photo'],
    );
  }

  @override
  List<Object?> get props => [email, id, contactId, firstName, name,birthDate, photo];
}

