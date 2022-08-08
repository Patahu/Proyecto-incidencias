import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../util/authUser.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object?> get props => [];
}

// tres estados:
// No inicializado -> Muestra el splash screen
// Autenticado -> Home
// No autenticado -> Login

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'No inicializado';
}

class Authenticated extends AuthenticationState {
  final AuthUser? user;
  const Authenticated(this.user);
  @override
  List<Object?> get props => [user];
  @override
  String toString() => 'Autenticado - NUMERO: ${user?.numero}';
}

class unauthenticated extends AuthenticationState {
  @override
  String toString() => 'No autenticado';
}
