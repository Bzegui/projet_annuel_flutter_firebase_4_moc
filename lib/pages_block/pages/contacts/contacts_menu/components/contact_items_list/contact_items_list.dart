import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/users_exports.dart';

import '../../../bloc/contacts_bloc.dart';
import '../contact_item/contact_item.dart';

class ContactItemsList extends StatefulWidget {
  const ContactItemsList({Key? key}) : super(key: key);

  @override
  State<ContactItemsList> createState() => _ContactItemsListState();
}

class _ContactItemsListState extends State<ContactItemsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          BlocBuilder<ContactsBloc, ContactsState>(
              builder: (context, state) {
                debugPrint('${state.contactUserItemsList}');
                switch (state.contactsStatus) {
                  case ContactsStatus.fetchingContacts:
                    return const SizedBox(
                      height: 80,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  case ContactsStatus.fetchedContacts:
                    return _buildContactItemsList(context, state.retrievedContactUsers);
                  default:
                    return _buildContactItemsList(context, state.retrievedContactUsers);
                }

                  return _buildContactItemsList(context,
                          state.retrievedContactUsers);
                }
          ),
        ]
    );
  }

  Widget _buildContactItemsList(BuildContext context, List<User>
  contactUserItemsList) {
    if (contactUserItemsList.isEmpty) {
      return const SizedBox(
        height: 80,
        child: Center(child: Text(
          "Aucun contact disponible",
          style: TextStyle(
            fontSize: 15,
          ),
        )),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: contactUserItemsList.length,
      itemBuilder: (context, index) {
        final contactUser = contactUserItemsList[index];
        return ContactUserItem(
          user: contactUser,
        );
      },
    );
  }
}
