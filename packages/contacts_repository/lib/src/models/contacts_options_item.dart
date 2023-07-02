import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ContactsOptionsItem extends Equatable {
  const ContactsOptionsItem({
    required this.id,
    required this.icon,
    required this.label,
    required this.navDestination
  });

  final String id;
  final IconData icon;
  final String label;
  final dynamic navDestination;

  @override
  List<Object> get props => [id, icon, label, navDestination];
}