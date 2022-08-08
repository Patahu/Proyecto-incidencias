import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../repository/user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(Uninitialized());

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }
    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final user = await _userRepository.getUsuario();
        yield Authenticated(user);
      } else {
        yield unauthenticated();
      }
    } catch (_) {
      yield unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await _userRepository.getUsuario());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield unauthenticated();
    _userRepository.signOut();
  }
}
