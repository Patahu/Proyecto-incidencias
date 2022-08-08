import 'package:equatable/equatable.dart';

import '../../util/notificacitionMessaging.dart';

abstract class MessagingEvent extends Equatable {
  const MessagingEvent();

  @override
  List<Object> get props => [];
}

class startMessagingListener extends MessagingEvent {}
class startFirebaseListener extends MessagingEvent {

  final String idUsuario;

  const startFirebaseListener(this.idUsuario);

  @override
  List<Object> get props => [idUsuario];
}
class entregarToken extends MessagingEvent {
  final List<NotificationMessaging> mes;
  entregarToken(this.mes);
  @override
  List<Object> get props => [mes];
}
class addMessaging extends MessagingEvent {
  final NotificationMessaging mes;

  addMessaging(this.mes);

  @override
  List<Object> get props => [mes];
}

class addMensajeInWait extends MessagingEvent {
  final NotificationMessaging mes;
  addMensajeInWait(this.mes);
  @override
  List<Object> get props => [mes];
}

class requiredRefresh extends MessagingEvent {}
