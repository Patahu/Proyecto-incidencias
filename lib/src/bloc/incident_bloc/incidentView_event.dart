import 'package:equatable/equatable.dart';

import '../../util/incident.dart';

abstract class incidentViewEvent extends Equatable {
  const incidentViewEvent();
  @override
  List<Object> get props => [];
}

class BuscarIncidentesEvent extends incidentViewEvent {
  final String idUsuario;

  const BuscarIncidentesEvent(this.idUsuario);

  @override
  List<Object> get props => [idUsuario];
}

class updateIncidentesEvent extends incidentViewEvent {
  final List<Incidentes> incidentes;
  const updateIncidentesEvent(this.incidentes);
  @override
  List<Object> get props => [incidentes];
}
