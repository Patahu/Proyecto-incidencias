

import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable{
  const AuthenticationEvent();
  @override
  List<Object> get props=>[];
}

// Tres eventos

class AppStarted extends AuthenticationEvent{}

class AnimationFinish extends AuthenticationEvent{}
class LoggedIn extends AuthenticationEvent{}

class LoggedOut extends AuthenticationEvent{}
