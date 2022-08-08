import '../../util/incident.dart';

class IncidentViewState {
  final bool isNewMessaging;
  final List<Incidentes>? mensajes;

  IncidentViewState({required this.isNewMessaging, this.mensajes});

  factory IncidentViewState.empty() {
    return IncidentViewState(
      isNewMessaging: true,
      mensajes: null,
    );
  }
  IncidentViewState copyWith({
    bool? isNewMessaging,
    List<Incidentes>? mensajes,
  }) {
    return IncidentViewState(
      isNewMessaging: isNewMessaging ?? this.isNewMessaging,
      mensajes: mensajes ?? this.mensajes,
    );
  }

  IncidentViewState update({bool? isNewMessaging, List<Incidentes>? mensajes}) {
    return copyWith(
      isNewMessaging: isNewMessaging,
      mensajes: mensajes,
    );
  }

  @override
  String toString() {
    return '''
            isNewMesssaging ,$isNewMessaging,
            lista Incidentes: ${mensajes?.length},
''';
  }
}
