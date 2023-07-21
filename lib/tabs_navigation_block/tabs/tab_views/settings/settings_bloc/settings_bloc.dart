import 'dart:async';
import 'dart:io';

import 'package:authentication_repository/authentication_repository_exports.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/tabs_navigation_block/tabs/tab_views/settings/UserRepository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UserRepository userRepository;

  SettingsBloc(this.userRepository) : super(SettingsState.initial);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SaveSettingsEvent) {
      yield SettingsState.loading;

      final result = await userRepository.saveUserProfile(event.user, event.imageFile);
      if (result == 'success') {
        yield SettingsState.success;
      } else {
        yield SettingsState.error;
      }
    }
  }
}