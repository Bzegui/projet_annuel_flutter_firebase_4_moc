import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components_exports.dart';
import '../contacts_options_item/bloc/contacts_options_items_bloc.dart';


class ContactsOptionsList extends StatelessWidget {
  const ContactsOptionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactsOptionsItemsBloc>(
        create: (context) => ContactsOptionsItemsBloc(
          contactsOptionsRepository: RepositoryProvider.of<ContactsOptionsItemsRepository>(context),
        )..add(GetAllContactsOptionsItems()),
        child: Builder(
            builder: (context) {
              return Column(
                  children: [
                    BlocBuilder<ContactsOptionsItemsBloc,
                        ContactsOptionsItemsRepositoryState>(
                        builder: (context, state) {
                          switch (state.status) {
                            case ContactsOptionsItemsStatus.initial:
                              return const Text('aucune option disponible');
                            case ContactsOptionsItemsStatus.loading:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case ContactsOptionsItemsStatus.error:
                              return Center(
                                child: Text(state.error),
                              );
                            case ContactsOptionsItemsStatus.success:
                              final contactsOptionsItems =
                                  state.contactsOptionsItem;

                              if (contactsOptionsItems.isEmpty) {
                                return const Center(
                                  child: Text('aucune option disponible'),
                                );
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: contactsOptionsItems.length,
                                itemBuilder: (context, index) {
                                  final contactsOptionsItem =
                                  contactsOptionsItems[index];
                                  return ContactOptionsItems(
                                    contactsOptionsItem: contactsOptionsItem,
                                  );
                                },
                              );
                          }
                        }
                    ),
                  ]
              );
            }
        ),
      );
  }
}
