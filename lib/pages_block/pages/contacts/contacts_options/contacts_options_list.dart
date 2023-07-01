import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/contacts_options_bloc.dart';
import 'contacts_options_item.dart';

class ContactsOptionsList extends StatelessWidget {
  const ContactsOptionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactsOptionsRepository(
          contactsOptionsDataSource: ContactsOptionsDataSource()
      ),
      child: BlocProvider<ContactsOptionsBloc>(
        create: (context) => ContactsOptionsBloc(
          contactsOptionsRepository: RepositoryProvider.of<ContactsOptionsRepository>(context),
        )..add(GetAllContactsOptions()),
        child: Builder(
            builder: (context) {
              return Column(
                children: [
                  BlocBuilder<ContactsOptionsBloc, ContactsOptionsRepositoryState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case ContactsOptionsStatus.initial:
                            return const Text('aucune option disponible');
                          case ContactsOptionsStatus.loading:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case ContactsOptionsStatus.error:
                            return Center(
                              child: Text(state.error),
                            );
                          case ContactsOptionsStatus.success:
                            final contactsOptions = state.contactsOptions;

                            if (contactsOptions.isEmpty) {
                              return const Center(
                                child: Text('aucune option disponible'),
                              );
                            }

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: contactsOptions.length,
                            itemBuilder: (context, index) {
                              final contactsOption = contactsOptions[index];
                              return ContactOptionItem(
                                contactsOption: contactsOption,
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
      ),
    );
  }
}
