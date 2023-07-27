import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/tabs_navigation_block/tabs/tab_views/settings/settings_bloc/settings_bloc.dart';
import 'package:users/src/users_repository/users_repository.dart';
import 'package:users/users_exports.dart';
class MockUsersRepository extends Mock implements UsersRepository {
}

void main() {
  group('SettingsBloc', () {
    late MockUsersRepository mockUsersRepository;
    late SettingsBloc settingsBloc;

    setUp(() {
      mockUsersRepository = MockUsersRepository();
      settingsBloc = SettingsBloc(mockUsersRepository);
    });
    //successful
    test('Emits SettingsState.success when save is successful', () async {
      const user = User(id: '1WTXU9OGSUP0hzW1o7iYc8Lbi7D2');
      final imageFile = File('https://firebasestorage.googleapis.com/v0/b/projet-annuel-flutter-firebase.appspot.com/o/profile_images%2F1690097919856.jpg?alt=media&token=3f119f68-b4f5-41e1-9538-d57e7fada499'); // mon fichier
      when(mockUsersRepository.saveUserProfile(
          user,
          imageFile) as Function())
          .thenAnswer((_) async => 'success');

      settingsBloc.add(SaveSettingsEvent(user,imageFile));
      await untilCalled(mockUsersRepository.saveUserProfile(any as User, any as File?) as Function());

      expectLater(
        settingsBloc.stream,
        emitsInOrder([SettingsState.loading, SettingsState.success]),
      );
    });
    // Error
    test('Emits SettingsState.error when save fails', () async {
      const user = User(id: '1WTXU9OGSUP0hzW1o7iYc8Lbi7D2');
      final imageFile = File('https://firebasestorage.googleapis.com/v0/b/projet-annuel-flutter-firebase.appspot.com/o/profile_images%2F1690097919856.jpg?alt=media&token=3f119f68-b4f5-41e1-9538-d57e7fada499'); // mon fichier

      when(mockUsersRepository.saveUserProfile(any as User, any as File?) as Function())
          .thenAnswer((_) => Future.value('error'));

      settingsBloc.add(SaveSettingsEvent(user,imageFile));
      await untilCalled(mockUsersRepository.saveUserProfile(any as User, any as File?) as Function());

      expectLater(
        settingsBloc.stream,
        emitsInOrder([SettingsState.loading, SettingsState.error]),
      );
    });
  });
}

