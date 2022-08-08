import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/data_base_incidents.dart';
import 'bloc.dart';

class IncidenciasBloc extends Bloc<incidentViewEvent, IncidentViewState> {
  final DataBaseIncident _dataBaseIncident;
  StreamSubscription? _subscriptionTodo1=null;
  IncidenciasBloc({required DataBaseIncident dataBaseIncident})
      : _dataBaseIncident = dataBaseIncident,
        super(IncidentViewState.empty());

  IncidentViewState get initialState => IncidentViewState.empty();

  @override
  Stream<IncidentViewState> mapEventToState(incidentViewEvent event) async* {
    if (event is BuscarIncidentesEvent) {
      if (_subscriptionTodo1 != null) {
        _subscriptionTodo1!.cancel();
      }
      _subscriptionTodo1=_dataBaseIncident.datosIncidentes(event.idUsuario).listen((incidentes) {
          add(updateIncidentesEvent(incidentes));
        });

    } else if (event is updateIncidentesEvent) {
      yield state.update(isNewMessaging: true, mensajes: event.incidentes);
    }
  }
}