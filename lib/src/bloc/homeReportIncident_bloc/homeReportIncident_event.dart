import 'package:equatable/equatable.dart';

import '../../util/authUser.dart';
import '../../util/incident.dart';

abstract class reportIncidentEvent extends Equatable {
  const reportIncidentEvent();
  @override
  List<Object> get props => [];
}

// evento que indica el busqueda de foto
class insertPhotoIncident extends reportIncidentEvent {
  final bool isGallery;

  insertPhotoIncident(this.isGallery);
  List<Object> get props => [isGallery];
  @override
  String toString() => 'tipoIncidente {tipo: $isGallery}';
}

class insertVideoIncident extends reportIncidentEvent {
  final bool isGallery;

  insertVideoIncident(this.isGallery);
  List<Object> get props => [isGallery];
  @override
  String toString() => 'tipoIncidente {tipo: $isGallery}';
}

// envento que indica que debe subirse a la base de datos
class reportIncidentUploadToDb extends reportIncidentEvent {}

class reportIncidentToDb extends reportIncidentEvent {}

class enterIncidentDatos extends reportIncidentEvent {}

class SacarLocalizacionUsuario extends reportIncidentEvent {}

class inicialR extends reportIncidentEvent {}

class inicialWhatssapp extends reportIncidentEvent {}

class iniciarTelefonos extends reportIncidentEvent {}

class enterTipo extends reportIncidentEvent {
  final String tipo;
  final AuthUser authUser;
  enterTipo(this.tipo, this.authUser);
  @override
  List<Object> get props => [tipo, authUser];
  @override
  String toString() =>
      'tipoIncidente {tipo: $tipo}, usuario: {user:${authUser.uid}}';
}

class chaDescripcionUsuario extends reportIncidentEvent {
  final String descripcion;

  chaDescripcionUsuario(this.descripcion);
  @override
  List<Object> get props => [descripcion];
  @override
  String toString() => 'descripcionCambio {descripcion: $descripcion}';
}

