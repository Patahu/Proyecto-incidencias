import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  String _uid;
  String _nombre;
  String _correo;
  String _numero;
  String _dni;
  AuthUser(this._uid, this._nombre, this._correo, this._numero,this._dni);

  static AuthUser fromUsers(
      String uid, String nombre, String correo, String numero,String dni) {
    AuthUser empresa = AuthUser(uid, nombre, correo, numero,dni);
    return empresa;
  }

  String get uid => _uid;
  String get correo => _correo;
  String get numero => _numero;
  String get nombre => _nombre;
  String get dni => _dni;

  void set seDNIUsuario(String dni) {
    _dni = dni;
  }

  void set seUID(String uid) {
    _uid = uid;
  }
  void set seNombre(String nombre) {
    _nombre = nombre;
  }
  void set seCorreo(String correo) {
    _correo = correo;
  }
  void set seTelefono(String telefono) {
    _numero = telefono;
  }
  @override
  // TODO: implement props
  List<Object> get props => [uid, correo, numero, nombre,dni];
}
