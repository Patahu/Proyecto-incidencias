import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../util/notificacitionMessaging.dart';
import 'package:cloud_functions/cloud_functions.dart';
class FirebaseMessagingD {
  final FirebaseMessaging _firebaseMessaging;

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FirebaseMessagingD({FirebaseMessaging? firebaseMessaging})
      : _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance {
    requestPermission();
  }

  void requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print(
          '----------------------------Asignacion de usuario autorizado');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('Se a otorgado permisos provisionales');
    } else {
      print('Se ha denegado el permiso al usuario');
    }
  }
  Future<void> writeMessage(String token,String idNotification) async {

    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('myNotifacionConsul');
    final resp =  callable.call(<String, dynamic>{
      'idNotificacion':idNotification,
      'token':token,
    });

  }
  Future<String?> gettoken() async {
    return _firebaseMessaging.getToken();
    
  }

  Stream<NotificationMessaging?> listenFCM() {
    return FirebaseMessaging.onMessage.map((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        NotificationMessaging? mes =
            NotificationMessaging.fromUser(notification.body, notification.title,' ');
        return mes;
      }
    });
  }
}
