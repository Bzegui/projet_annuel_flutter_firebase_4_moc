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
    required this.unique_identifier,
    this.email,
    this.name,
    this.firstName,
    this.dateOfBirth,
    this.photo,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  final String unique_identifier;

  /// The current user's name (display name).
  final String? name;

  final String? firstName;
  /// Url for the current user's photo.

  final String? dateOfBirth;

  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '', unique_identifier: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, unique_id, name, firstName, dateOfBirth, photo];

  get unique_id => null;
}

