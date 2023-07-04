import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/pages_block/pages/contacts/add_contact/cubit/add_contact_cubit.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/pages_block/pages/contacts/add_contact/view/add_contact_form.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/pages_block/pages/contacts/bloc/contacts_bloc.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: AddContactPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: BlocProvider<AddContactCubit>(
              create: (_) => AddContactCubit(context.read<ContactsRepository>()),
              child: const AddContactForm(),
            ),
          ),
      );
  }
}
