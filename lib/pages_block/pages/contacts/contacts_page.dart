import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/pages_block/pages/contacts/contacts_options_list/contacts_options_list.dart';

class ContactsPage extends StatelessWidget {

  const ContactsPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: ContactsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: RepositoryProvider(
              create: (context) => ContactsOptionsItemsRepository(
              contactsOptionsItemsDataSource: ContactsOptionsItemsLocalDataSource()),
              child: Builder(
                  builder: (context) {
                    return  CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                            delegate: SliverChildListDelegate(
                                [
                                  const ContactsOptionsList(),
                                ]
                            )
                        )
                      ],
                    );
                  }
              ),
            ),
      );
  }

  void _onCreateNewContact(BuildContext context) {

  }
}

