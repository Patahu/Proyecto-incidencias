import 'package:equatable/equatable.dart';

import '../../util/authUser.dart';

abstract class perfilViewEvent extends Equatable {
  const perfilViewEvent();
  @override
  List<Object> get props => [];
}

class chaTelefonocionUsuario extends perfilViewEvent {
  final String telefono;

  chaTelefonocionUsuario(this.telefono);
  @override
  List<Object> get props => [telefono];
  @override
  String toString() => 'telefonoCambio {telefono: $telefono}';
}
class chaDNIUsuarioEnable extends perfilViewEvent {

}
class chaTelefonoUsuarioEnable extends perfilViewEvent {

}
class chaTelefonoUsuarioCancel extends perfilViewEvent {

}
class chaNombreUsuarioEnable extends perfilViewEvent {

}
class chaNombreUsuarioCancel extends perfilViewEvent {

}
class chaDNIUsuarioCancel extends perfilViewEvent {

}
class chaNombreUsuario extends perfilViewEvent {
  final String nombre;

  chaNombreUsuario(this.nombre);
  @override
  List<Object> get props => [nombre];
  @override
  String toString() => 'nombreCambio {nombre: $nombre}';
}
class chaDNIUsuario extends perfilViewEvent {
  final String dni;

  chaDNIUsuario(this.dni);
  @override
  List<Object> get props => [dni];
  @override
  String toString() => 'dniCambio {dni: $dni}';
}
class chaDatasUsuarioDB extends perfilViewEvent {

}


class iniciarUsuarioVerificar extends perfilViewEvent {

  final AuthUser authUser;
  iniciarUsuarioVerificar( this.authUser);
  @override
  List<Object> get props => [ authUser];
  @override
  String toString() =>
      'usuario: {user:${authUser.uid} }';
}