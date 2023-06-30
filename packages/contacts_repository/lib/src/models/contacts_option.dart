import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ContactsOption extends Equatable {
  const ContactsOption({
    required this.id,
    required this.icon,
    required this.label
  });

  final String id;
  final IconData icon;
  final String label;

  @override
  List<Object> get props => [id, icon, label];
}