import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:authentication_repository/authentication_repository_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'UserRepository.dart';
import 'settings_bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: SettingsPage());

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    final settingsBloc = SettingsBloc(userRepository);

    return BlocProvider(
      create: (context) => settingsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ProfileImagePicker(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final settingsBloc = context.read<SettingsBloc>();
                  settingsBloc.add(SaveSettingsEvent(
                    const User(
                      firstName: "John",
                      name: "Doe",
                      dateOfBirth: "2000-01-01",
                      unique_identifier: '',
                      id: '',
                    ),

                    null,
                  ));
                },
                child: const Text('Save'),
              ),
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {

                  if (state == SettingsState.success) {
                    return const Text('Save successful');
                  } else if (state == SettingsState.error) {
                    return const Text('Error occurred while saving');
                  } else if (state == SettingsState.loading) {
                    return const CircularProgressIndicator();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileImagePicker extends StatefulWidget {
  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Align(
          alignment: Alignment.center, // Center the child within the column
          child: GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
              child: _imageFile == null ? const Icon(Icons.person, size: 40) : null,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Profile Photo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

}