
import 'package:aplicacionincidentes/src/repository/user_repository.dart';
import 'package:aplicacionincidentes/src/util/incident.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../util/notificacitionMessaging.dart';


class DataBaseIncident {
  final FirebaseFirestore _firebaseFirestore;
  final UserRepository _userRepository;
  DataBaseIncident({FirebaseFirestore? firebaseFirestore,required UserRepository userRepository})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _userRepository = userRepository;

  Stream<List<Incidentes>> datosIncidentes(String idUsuario) {
    return _firebaseFirestore
        .collection("IncidenciasAtenderF").where('idUsuario',isEqualTo: idUsuario)
        .snapshots()
        .map((snapshot) {
      List<Incidentes> po =
          snapshot.docs.map((doc) => Incidentes.fromDB(doc)).toList();
      return po;
    });
  }

  Stream<List<NotificationMessaging>> datosNotificaciones(String idUsuario) {
    return _firebaseFirestore
        .collection("notificacion")
        .where('idUsuario',isEqualTo: idUsuario)
        .where('estado', isEqualTo:'Pendiente')
        .snapshots()
        .map((snapshot) {
      List<NotificationMessaging> po =snapshot.docs.map((doc) => NotificationMessaging.fromUser(doc['cuerpo'],doc['estado'],doc['idNotificacion'])).toList();
      return po;
    });
  }
  Future<void> insertIncident(Incidentes incidente) async {
    final tiempo=Timestamp.fromDate(DateTime.now());
    final String idDocumento=incidente.idUsuario.toString()+
        tiempo.toDate().year.toString()+
        tiempo.toDate().month.toString()+
        tiempo.toDate().day.toString()+
        tiempo.toDate().hour.toString()+
        tiempo.toDate().minute.toString()+
        tiempo.toDate().second.toString();


    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('myid');
    final resp =  callable.call(<String, dynamic>{
      'tipo': incidente.tipo,
      'descripcion': incidente.descripcion,
      'estado':'Pendiente',
      'idUsuario':incidente.idUsuario,
      'video':incidente.video,
      'idFotos':incidente.fotos,
      'fecha':'',
      'fechaE':null,
      'fechaR':null,
      'longitude':incidente.locationData!.longitude,
      'latitude':incidente.locationData!.latitude,
    });

  }
}
