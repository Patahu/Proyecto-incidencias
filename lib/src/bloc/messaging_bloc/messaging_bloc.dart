import 'package:aplicacionincidentes/src/repository/firebase_messaging.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';

import '../../repository/data_base_incidents.dart';
import '../../util/notificacitionMessaging.dart';
import 'bloc.dart';


class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  FirebaseMessagingD? _firebaseMessaging;
  StreamSubscription? _categorySubscripcion;
  NotificationMessaging? _remoteWaitss;
  StreamSubscription? _subscriptionTodo1=null;
  final DataBaseIncident _dataBaseIncident;
  MessagingBloc({FirebaseMessagingD? firebaseMessaging,required DataBaseIncident dataBaseIncident})
      : _firebaseMessaging = firebaseMessaging,
        _dataBaseIncident=dataBaseIncident,
        super(MessagingState.empty());
  MessagingState get initialState => MessagingState.empty();
  @override
  Stream<MessagingState> mapEventToState(MessagingEvent event) async* {
    if(event is startFirebaseListener){
      if (_subscriptionTodo1 != null) {
        _subscriptionTodo1!.cancel();
      }
      _subscriptionTodo1=_dataBaseIncident.datosNotificaciones(event.idUsuario).listen((notificacion) {
        if(notificacion.isNotEmpty){

          add(entregarToken(notificacion));
        }
      });
    }else if(event is entregarToken){

      final vio =await  _firebaseMessaging!.gettoken();
      for(NotificationMessaging idNotificacion in event.mes){
        _firebaseMessaging!.writeMessage(vio!, idNotificacion.idNotificacion);
      }


    }
    if (event is startMessagingListener) {

      _categorySubscripcion ??=
          _firebaseMessaging?.listenFCM().listen((mensajes) {
        add(addMessaging(mensajes!));
      });
    } else if (event is addMessaging) {
      yield state.update(isNewMessaging: true, token: event.mes.titulo);
      yield state.update(isNewMessaging: false,);
    } else if (event is requiredRefresh) {

      yield state.update(
          needRefresh: false,
          isNewMessaging: true,
          token: _remoteWaitss?.titulo);
    }
  }

  void setFirebaseMessage(FirebaseMessagingD? firebaseMessaging) {
    _firebaseMessaging = firebaseMessaging;
  }

  setRemotewait(NotificationMessaging mess) {
    _remoteWaitss = mess;
  }
}
