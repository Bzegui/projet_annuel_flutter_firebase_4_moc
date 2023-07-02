import 'dart:async';

import 'package:authentication_repository/authentication_repository_exports.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_auth_event.dart';
part 'app_auth_state.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  AppAuthBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
        authenticationRepository.currentUser.isNotEmpty
            ? AppAuthState.authenticated(authenticationRepository.currentUser)
            : const AppAuthState.unauthenticated(),
      ) {
    on<_AppAuthUserChanged>(_onUserChanged);
    on<AppAuthLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
          (user) => add(_AppAuthUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(_AppAuthUserChanged event, Emitter<AppAuthState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppAuthState.authenticated(event.user)
          : const AppAuthState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppAuthLogoutRequested event, Emitter<AppAuthState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
