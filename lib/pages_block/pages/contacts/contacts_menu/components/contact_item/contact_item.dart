import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/users_exports.dart';

import '../../../bloc/contacts_bloc.dart';
import '../../view/contacts_page.dart';

class ContactUserItem extends StatelessWidget {
  const ContactUserItem({
    Key? key,
    required this.user,
    this.onTap,
  }) : super(key: key);

  final User user;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.contactId ?? ''),
      subtitle: Text(user.name ?? ''),
      leading: Container(
        height: 41,
        width: 41,
        decoration: const BoxDecoration(
          color: Colors.indigoAccent,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.photo_album,
          color: Color(0xFFE0F2F1),
        ),
      ),
      onTap: () {
        final contactsBloc = BlocProvider.of<ContactsBloc>(context);
        contactsBloc.add(AddContactUserToContactUserItemsList(user));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactsPage()),
        );
      },
    );
  }
}