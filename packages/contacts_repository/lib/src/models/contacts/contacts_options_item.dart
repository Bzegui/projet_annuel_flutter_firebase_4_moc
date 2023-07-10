import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

/// {@template contactOptionsItem}
/// ContactOptionsItem model
///
/// {@endtemplate}

class ContactsOptionsItem extends Equatable {
  /// {@macro contactOptionsItem}
  const ContactsOptionsItem({
    required this.id,
    required this.icon,
    required this.label,
    required this.navDestination
  });

  /// The current contacts options item's id.
  final String id;

  /// The current contacts options item's related icon.
  final IconData icon;

  /// The current contacts options item's label.
  final String label;

  /// The current contacts options item's related navigation destination.
  final dynamic navDestination;

  @override
  List<Object> get props => [id, icon, label, navDestination];
}