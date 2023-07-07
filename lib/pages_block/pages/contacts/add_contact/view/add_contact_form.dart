import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/pages_block/pages/contacts/bloc/contacts_bloc.dart';

import '../../contact_item/contact_item.dart';

class AddContactForm extends StatefulWidget {
  const AddContactForm({Key? key}) : super(key: key);

  @override
  State<AddContactForm> createState() => _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm> {
  @override
  void didChangedDependencies() {
    super.didChangeDependencies();
  }

 /* @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          switch (state.contactsStatus) {
            case ContactsStatus.fetchingContacts:
              return const Center(child: CircularProgressIndicator());
            case ContactsStatus.fetchedContacts:
              return _buildContactsList(context, state.contacts);
            default:
              return _buildContactsList(context, state.contacts);
          }
        },
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactsBloc, ContactsState>(
      listener: (context, state) {
        if (state.addContactStatus.isSuccess) {
        } else if (state.addContactStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Failed adding contact')),
            );
        }
      },
      child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child:  SizedBox(
                  height: 60,
                  child: Text(
                      "Ajouter un contact",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      )
                  ),
                  //
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 5),
                    child:  SizedBox(
                      height: 70, width: 200,
                      child: _ContactIdInput(),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                height: 1,
              ),

              BlocBuilder<ContactsBloc, ContactsState>(
                builder: (context, state) {
                  /*switch (state.addContactStatus) {
                    case FormzSubmissionStatus.inProgress:
                      return const Center(child: CircularProgressIndicator());
                    case FormzSubmissionStatus.success:
                      return _buildContactsList(context, state.contacts);
                    case FormzSubmissionStatus.failure:

                    default:
                      return _buildContactsList(context, state.contacts);
                  }*/
                  switch (state.contactsStatus) {
                    case ContactsStatus.fetchingContacts:
                      return const Center(child: CircularProgressIndicator());
                    case ContactsStatus.fetchedContacts:
                      return _buildContactsList(context, state.contacts);
                    default:
                      return _buildContactsList(context, state.contacts);
                  }
                },
              )
            ],
          )
      ),
    );
  }

  Widget _buildContactsList(BuildContext context, List<Contact> contacts) {
    if (contacts.isEmpty) {
      return const Center(child: Text('No contacts'));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ContactItem(
          contact: contact,
        );
      },
    );
  }
}


class _ContactIdInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
        buildWhen: (previous, current) => previous.contactId
            != current.contactId,
        builder: (context, state) {
          return TextField(
            key: const Key('addContactForm_contactIdInput_textField'),
            onChanged: (contactId) => context.read<ContactsBloc>()
                .add(AddContactById(contactId)), /*context.read<ContactsBloc>()
                .add(GetAllContacts()),*/
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'contactId',
              helperText: '',
              errorText:
                state.contactId.displayError != null ?
                'invalid contact ID' : null
            ),
          );
        },
    );
  }
}

