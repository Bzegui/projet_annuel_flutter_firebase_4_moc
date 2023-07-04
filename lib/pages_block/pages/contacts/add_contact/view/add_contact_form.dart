import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/pages_block/pages/contacts/add_contact/cubit/add_contact_cubit.dart';

class AddContactForm extends StatelessWidget {
  const AddContactForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddContactCubit, AddContactState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
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
            const SizedBox(height: 8),
            _ContactIdInput(),
            _AddContactButton(),
          ],
        ),
      ),
    );
  }
}

class _ContactIdInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddContactCubit, AddContactState>(
        buildWhen: (previous, current) => previous.contactId
            != current.contactId,
        builder: (context, state) {
          return TextField(
            key: const Key('addContactForm_contactIdInput_textField'),
            onChanged: (contactId) => context.read<AddContactCubit>()
                .contactIdChanged(contactId),
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


class _AddContactButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddContactCubit, AddContactState>(
        builder: (context, state) {
          return state.status.isInProgress
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  key: const Key('addContactForm_continue_raisedButton'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.indigoAccent,
                  ),
                  onPressed: state.isValid
                      ? () => context.read<AddContactCubit>()
                      .addContactFormSubmitted() : null,
                  child: const Text('ADD'),
          );
        }
    );
  }
}

