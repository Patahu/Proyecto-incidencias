import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

// Email change - cambio en el email
class EmailChanged extends ResetPasswordEvent {
  final String email;
  const EmailChanged({required this.email});
  @override
  List<Object> get props => [email];
  @override
  String toString() => 'EmailChanged {email: $email}';
}

// Submitted - enviado
class Submitted extends ResetPasswordEvent {
  final String email;

  const Submitted({required this.email});
  @override
  List<Object> get props => [email];
  @override
  String toString() => 'Sumitted{email: $email';
}
