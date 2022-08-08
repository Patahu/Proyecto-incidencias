import 'package:equatable/equatable.dart';

class NotificationMessaging extends Equatable {
  final String? _titulo;
  final String? _cuerpo;
  final String _idNotificacion;
  NotificationMessaging(String? this._titulo, String? this._cuerpo,String this._idNotificacion);
  static NotificationMessaging fromUser(String? titulo, String? cuerpo,String idNotificacion) {
    NotificationMessaging empresa = NotificationMessaging(titulo, cuerpo,idNotificacion);
    return empresa;
  }

  String? get titulo => _titulo;
  String? get cuerpo => _cuerpo;
  String get idNotificacion => _idNotificacion;

  @override
  // TODO: implement props
  List<Object?> get props => [_titulo, _cuerpo];
}
