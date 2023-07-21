import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/users_exports.dart';
import '../../bloc/contacts_bloc.dart';
import '../components/components_exports.dart';


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
              child: BlocProvider<ContactsBloc>(
                  create: (context) => ContactsBloc(
                      usersRepository: context.read<UsersRepository>()
                  ),
                child: Builder(
                    builder: (context) {
                      return  CustomScrollView(
                        slivers: <Widget>[
                          SliverList(
                              delegate: SliverChildListDelegate(
                                  [
                                    const ContactsOptionsList(),
                                    const ContactItemsList(),
                                  ]
                              )
                          )
                        ],
                      );
                    }
                ),
              )



            ),
      );
  }

  void _onCreateNewContact(BuildContext context) {

  }
}

