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
      body: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ContactsOptionsItemsRepository>(
            create: (context) => ContactsOptionsItemsRepository(
              contactsOptionsItemsDataSource: ContactsOptionsItemsLocalDataSource()
            ),
          ),
        ],
        child:
            Builder(
                builder: (context) {
                  return  CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                          delegate: SliverChildListDelegate(
                              [
                                const ContactsOptionsList(),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: SizedBox(
                                    height: 30, width: 200,
                                    child: Divider(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                  ),
                                ),
                                const ContactItemsList(),
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

