import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/pages_block/pages/contacts/add_contact/cubit/add_contact_cubit.dart';

class AddContactForm extends StatelessWidget {
  const AddContactForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddContactCubit, AddContactState>(
        builder: (context, state) {
          return state.status.isInProgress
              ? const CircularProgressIndicator()
              : ElevatedButton(
            key: const Key('signUpForm_continue_raisedButton'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.deepPurpleAccent,
            ),
            onPressed: state.isValid
                ? () => context.read<AddContactCubit>().addContactFormSubmitted()
                : null,
            child: const Text('ADD'),
          );
        }
    );
  }
}
