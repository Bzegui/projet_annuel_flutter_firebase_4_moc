import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/users_exports.dart';
import 'settings_bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  final User currentUser;

  const SettingsPage({Key? key, required this.currentUser}) : super(key: key);

  static Page<void> page(User currentUser) => MaterialPage<void>(
    child: SettingsPage(currentUser: currentUser),
  );

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController =
    TextEditingController(text: currentUser.firstName);
    final TextEditingController lastNameController =
    TextEditingController(text: currentUser.name);
    final TextEditingController birthDateController =
    TextEditingController(text: currentUser.birthDate);

    UsersRemoteDataSource usersRemoteDataSource = UsersRemoteDataSource();
    final userRepository =
    UsersRepository(usersRemoteDataSource: usersRemoteDataSource);
    final settingsBloc = SettingsBloc(userRepository);

    return BlocProvider.value(
      value: settingsBloc,
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
                  controller: firstNameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
                  controller: lastNameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                  ),
                  controller: birthDateController,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final firstName = firstNameController.text;
                  final lastName = lastNameController.text;
                  final birthDate = birthDateController.text;
                  final settingsBloc = context.read<SettingsBloc>();
                  settingsBloc.add(
                    SaveSettingsEvent(
                      User(
                        firstName: firstName,
                        name: lastName,
                        birthDate: birthDate,
                        photo: '',
                        id: '',
                      ),
                      null,
                    ),
                  );
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
  String _downloadUrl = '';

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });

      // Upload the image to Firebase Storage and get its download URL
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _downloadUrl = downloadUrl;
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
              backgroundImage:
              _imageFile != null ? FileImage(_imageFile!) : null,
              child:
              _imageFile == null ? const Icon(Icons.person, size: 40) : null,
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
