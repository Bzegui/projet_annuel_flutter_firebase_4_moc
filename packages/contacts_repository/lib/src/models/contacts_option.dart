import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ContactsOption extends Equatable {
  const ContactsOption({
    required this.icon,
    required this.label
  });

  final IconData icon;
  final String label;

  @override
  List<Object> get props => [icon, label];
}