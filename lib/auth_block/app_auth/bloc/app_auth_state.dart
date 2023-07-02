part of 'app_auth_bloc.dart';

enum AppAuthStatus {
  authenticated,
  unauthenticated,
}

final class AppAuthState extends Equatable {
  const AppAuthState._({
    required this.status,
    this.user = User.empty,
  });

  const AppAuthState.authenticated(User user)
      : this._(status: AppAuthStatus.authenticated, user: user);

  const AppAuthState.unauthenticated() : this._(status: AppAuthStatus.unauthenticated);

  final AppAuthStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
