part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SaveSettingsEvent extends SettingsEvent {
  final User user;
  final File? imageFile;

  SaveSettingsEvent(this.user, this.imageFile);
}