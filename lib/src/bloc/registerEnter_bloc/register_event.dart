import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

// Eventos:
// EmailChanged
class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged {email: $email}';
}
class PhoneChanged extends RegisterEvent {
  final String numero;

  PhoneChanged({required this.numero});

  @override
  List<Object> get props => [numero];

  @override
  String toString() => 'numeroChanged {numero: $numero}';
}

class DNIChanged extends RegisterEvent {
  final String numero;

  DNIChanged({required this.numero});

  @override
  List<Object> get props => [numero];

  @override
  String toString() => 'DNIChanged {DNI: $numero}';
}
// PasswordChanged
class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged {password: $password}';
}

// PasswordChangedCofirm
class PasswordChangedCofirm extends RegisterEvent {
  final String password;
  final String passwordCofirm;

  PasswordChangedCofirm({required this.password, required this.passwordCofirm});

  @override
  List<Object> get props => [password, passwordCofirm];

  @override
  String toString() =>
      'PasswordChangedCofirm {password: ${password}, ${passwordCofirm}';
}

// Submitted
class Submitted extends RegisterEvent {
  final String email;
  final String password;
  final String nombre;
  final String numero;
  final String DNI;

  Submitted({required this.email, required this.password,required this.nombre,required this.numero,required this.DNI});

  @override
  List<Object> get props => [email, password,nombre,numero,DNI];

  @override
  String toString() => 'Submitted {email: $email, password: $password}, nombre:{$nombre}, numero:{$numero}, DNI: {$DNI}';
}
