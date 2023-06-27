part of 'app_auth_bloc.dart';

sealed class AppAuthEvent {
  const AppAuthEvent();
}

final class AppAuthLogoutRequested extends AppAuthEvent {
  const AppAuthLogoutRequested();
}

final class _AppAuthUserChanged extends AppAuthEvent {
  const _AppAuthUserChanged(this.user);

  final User user;
}
