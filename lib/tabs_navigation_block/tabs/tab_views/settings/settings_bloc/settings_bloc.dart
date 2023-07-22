import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:users/users_exports.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UsersRepository userRepository;

  SettingsBloc(this.userRepository) : super(SettingsState.initial) {
    on<SaveSettingsEvent>(_onSaveSettingsEvent);
  }

  void _onSaveSettingsEvent(SaveSettingsEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsState.loading);

    final result = await userRepository.saveUserProfile(event.user, event.imageFile);
    if (result == 'success') {
      emit(SettingsState.success);
    } else {
      emit(SettingsState.error);
    }
  }
}
